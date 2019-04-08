from trackerstudies.utils import load_runs
from sklearn.decomposition import PCA
from sklearn.preprocessing import StandardScaler
from sklearn.covariance import EllipticEnvelope
from sklearn.manifold import TSNE
from sklearn import svm
import pandas
import seaborn as sns
import matplotlib.pyplot as plt
import numpy as np
import numpy

# Load the pandas dataframe
runs = load_runs()  # First time will take a while

runs = runs.loc[runs.fill__era == "2018D", :]
runs = runs.loc[runs.reco.isin(["express", "prompt"]), :]
runs = runs.loc[runs["Hits.Pixel.mean"] > 0, :]
runs = runs.loc[runs["Hits.Strip.mean"] > 0, :]

runs.tracking = pandas.Categorical(runs.tracking, ["GOOD", "BAD"])
runs.bad_reason.fillna("GOOD", inplace=True)

runs.reset_index(inplace=True)  # Reset index

# Decide what features you want
column_names = list(runs)
feature_tokens = [
    ".rms",
    "mean",
]  # Only features for the RMS and mean value of histograms
my_feature_list = [
    column
    for column in column_names
    if any(token in column for token in feature_tokens) or column in ["recorded_lumi"]
]  # List of feature column names

# Extract feature matrix
feature_df = runs[my_feature_list].copy()
feature_df.fillna(0, inplace=True)  # Handle missing values
feature_df.reset_index(inplace=True)  # Reset Index
X = feature_df.loc[:, :].values  # Create feature matrix

# Extract labels
label_column_names = [
    "run_number",
    "fill_number",
    "reco",
    "fill__era",
    "pixel",
    "strip",
    "tracking",
    "bad_reason",
]
labels = runs[label_column_names]

y = runs.tracking.cat.codes
# y = pandas.Categorical(runs.tracking, ["GOOD", "BAD"]).codes

# Feature scaling
X = StandardScaler().fit_transform(X)

## PCA
number_of_principal_components = 2
pca = PCA(n_components=number_of_principal_components)
classifier = pca.fit(X)
principal_components = classifier.transform(X)
variance_ratio = sum(pca.explained_variance_ratio_)

## Create a PCA Dataframe
pca_df = pandas.DataFrame(principal_components, columns=["pc1", "pc2"])
pca_df = pandas.concat([pca_df, labels], axis=1)
pca_df.sort_values(["tracking", "run_number"], inplace=True)

bad_reason_colors = [
    (0.7019607843137254, 0.7019607843137254, 0.7019607843137254),
    (0.6509803921568628, 0.807843137254902, 0.8901960784313725),
    (0.12156862745098039, 0.47058823529411764, 0.7058823529411765),
    (0.6980392156862745, 0.8745098039215686, 0.5411764705882353),
    (0.2, 0.6274509803921569, 0.17254901960784313),
    (0.984313725490196, 0.6039215686274509, 0.6),
    (0.8901960784313725, 0.10196078431372549, 0.10980392156862745),
    (0.9921568627450981, 0.7490196078431373, 0.43529411764705883),
    (1.0, 0.4980392156862745, 0.0),
    (0.792156862745098, 0.6980392156862745, 0.8392156862745098),
    (0.41568627450980394, 0.23921568627450981, 0.6039215686274509),
    (1.0, 1.0, 0.6),
    (0.6941176470588235, 0.34901960784313724, 0.1568627450980392),
]

## Plot the PCA DF
ax = sns.scatterplot(x="pc1", y="pc2", hue="bad_reason", data=pca_df)
plt.title("Principal Component Analysis ({:.2%})".format(variance_ratio))
plt.savefig("pca.png")
plt.show()


##################################
# Running the classifiers
##################################

X = principal_components

## Extract all runs that are certified good and bad
good_df = pca_df[pca_df.tracking == "GOOD"]
bad_df = pca_df[pca_df.tracking == "BAD"]

## Create Feature matrix and split by good and bad
pca_features = ["pc1", "pc2"]
X_good = good_df.loc[:, pca_features].values
X_bad = bad_df.loc[:, pca_features].values


##################################
# Two class support vector machine
##################################

## Traing binary SVM classifier
svm_classifier = svm.SVC(gamma="scale")
svm_classifier.fit(X, y)

## Create a grid to draw the classifier
xx, yy = np.meshgrid(np.linspace(-20, 25, 500), np.linspace(-10, 35, 500))
Z = svm_classifier.decision_function(np.c_[xx.ravel(), yy.ravel()])
Z = Z.reshape(xx.shape)

## Draw the boundary
plt.contourf(xx, yy, Z, levels=np.linspace(Z.min(), 0, 10), cmap=plt.cm.PuBu)
a = plt.contour(xx, yy, Z, levels=[0], linewidths=2, colors="darkred")
plt.contourf(xx, yy, Z, levels=[0, Z.max()], colors="palevioletred")

## Draw the data points
b1 = plt.scatter(X_good[:, 0], X_good[:, 1], c="blueviolet", edgecolors="k")
b2 = plt.scatter(X_bad[:, 0], X_bad[:, 1], c="gold", edgecolors="k")
plt.title("Support Vector Machine (Two Class)")
plt.savefig("svm_twoclass.png")
plt.show()

##################################
# One class Suport vector machine
##################################

## Traing SVM classifier
nu = 0.07
gamma = "scale"
svm_classifier = svm.OneClassSVM(nu=nu, kernel="rbf", gamma=gamma)
svm_classifier.fit(X_good)

## Create a grid to draw the classifier
xx, yy = np.meshgrid(np.linspace(-20, 25, 500), np.linspace(-10, 35, 500))
Z = svm_classifier.decision_function(np.c_[xx.ravel(), yy.ravel()])
Z = Z.reshape(xx.shape)

## Draw the boundary
plt.contourf(xx, yy, Z, levels=np.linspace(Z.min(), 0, 10), cmap=plt.cm.PuBu)
a = plt.contour(xx, yy, Z, levels=[0], linewidths=2, colors="darkred")
plt.contourf(xx, yy, Z, levels=[0, Z.max()], colors="palevioletred")

## Draw the data points
b1 = plt.scatter(X_good[:, 0], X_good[:, 1], c="blueviolet", edgecolors="k")
b2 = plt.scatter(X_bad[:, 0], X_bad[:, 1], c="gold", edgecolors="k")
plt.title("Support Vector Machine (One Class)")
plt.savefig("svm_oneclass.png")
plt.show()


##################################
# Robust covariance
##################################

## Train robust covariance classifier
outliers_fraction = 0.05
robust_classifier = EllipticEnvelope(contamination=outliers_fraction)
robust_classifier.fit(X)

## Create a grid to draw the classifier
xx, yy = np.meshgrid(np.linspace(-20, 25, 500), np.linspace(-10, 35, 500))
Z = robust_classifier.decision_function(np.c_[xx.ravel(), yy.ravel()])
Z = Z.reshape(xx.shape)

## Draw the boundary
plt.contourf(xx, yy, Z, levels=np.linspace(Z.min(), 0, 10), cmap=plt.cm.PuBu)
a = plt.contour(xx, yy, Z, levels=[0], linewidths=2, colors="darkred")
plt.contourf(xx, yy, Z, levels=[0, Z.max()], colors="palevioletred")

## Draw the data points
b1 = plt.scatter(X_good[:, 0], X_good[:, 1], c="blueviolet", edgecolors="k")
b2 = plt.scatter(X_bad[:, 0], X_bad[:, 1], c="gold", edgecolors="k")
plt.title("Robust Covariance")
plt.savefig("robust_covariance.png")
plt.show()

##################################
# t-SNE
##################################

# Decide what features you want
column_names = list(runs)
feature_tokens = [
    ".rms",
    "mean",
]  # Only features for the RMS and mean value of histograms
my_feature_list = [
    column
    for column in column_names
    if any(token in column for token in feature_tokens)
    and "charge" in column
    or column in ["recorded_lumi", "delivered_lumi"]
]  # List of feature column names

# Extract feature matrix
feature_df = runs[my_feature_list].copy()
feature_df.fillna(0, inplace=True)  # Handle missing values
X = feature_df.loc[:, :].values  # Create feature matrix

X = StandardScaler().fit_transform(X)

tsne = TSNE()
tsne_components = tsne.fit_transform(X)

tsne_df = pandas.DataFrame(tsne_components, columns=["tsne1", "tsne2"])

big_df = pandas.concat([runs, tsne_df], axis=1)

ax = sns.scatterplot("tsne1", "tsne2", hue="tracking", data=big_df)
ax.set_title("t-SNE")
plt.savefig("t-sne.png")
plt.show()

##################################
# t-SNE on PCA
##################################

# Decide what features you want
column_names = list(runs)
feature_tokens = [
    ".rms",
    "mean",
]  # Only features for the RMS and mean value of histograms
my_feature_list = [
    column
    for column in column_names
    if any(token in column for token in feature_tokens) or column in ["recorded_lumi"]
]  # List of feature column names

# Extract feature matrix
feature_df = runs[my_feature_list].copy()
feature_df.fillna(0, inplace=True)  # Handle missing values

X = feature_df.loc[:, :].values  # Create feature matrix

# Feature scaling
X = StandardScaler().fit_transform(X)

## PCA
number_of_principal_components = 5
pca = PCA(n_components=number_of_principal_components)
principal_components = pca.fit_transform(X)

# TSNE
tsne = TSNE()
tsne_components = tsne.fit_transform(principal_components)

tsne_df = pandas.DataFrame(tsne_components, columns=["tsne1", "tsne2"])

big_df = pandas.concat([runs, tsne_df], axis=1)

ax = sns.scatterplot("tsne1", "tsne2", hue="bad_reason", data=big_df)
ax.set_title("t-SNE on PCA")
plt.savefig("t-sne_on_pca.png")
plt.show()
