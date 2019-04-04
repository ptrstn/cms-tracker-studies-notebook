#!/bin/bash

# Run Registry
runregcrawl --workspace tracker --min $FIRST_RUN_NUMBER --max $LAST_RUN_NUMBER
runregcrawl --workspace global --min $FIRST_RUN_NUMBER --max $LAST_RUN_NUMBER
runregcrawl --workspace tracker --runs-txt --min $FIRST_RUN_NUMBER --max $LAST_RUN_NUMBER
cat runs.txt | grep -i "online" > online_runs.txt
cat runs.txt | grep -iv "online" > offline_runs.txt

# DQM GUI
## 02a - Tracks (pp collisions)
dqmcrawl offline_runs.txt --resource "/Tracking/TrackParameters/highPurityTracks/pt_1/GeneralProperties/NumberOfTracks_GenTk"
dqmcrawl offline_runs.txt --resource "/Tracking/TrackParameters/highPurityTracks/pt_1/HitProperties/NumberOfRecHitsPerTrack_GenTk"
dqmcrawl offline_runs.txt --resource "/Tracking/TrackParameters/highPurityTracks/pt_1/GeneralProperties/TrackPt_ImpactPoint_GenTk"
dqmcrawl offline_runs.txt --resource "/Tracking/TrackParameters/highPurityTracks/pt_1/GeneralProperties/Chi2oNDF_GenTk"
dqmcrawl offline_runs.txt --resource "/Tracking/TrackParameters/highPurityTracks/pt_1/GeneralProperties/TrackPhi_ImpactPoint_GenTk"
dqmcrawl offline_runs.txt --resource "/Tracking/TrackParameters/highPurityTracks/pt_1/GeneralProperties/TrackEta_ImpactPoint_GenTk"

## 02b - Total Hits Strip and Pixel (pp)
dqmcrawl offline_runs.txt --resource "/Tracking/TrackParameters/highPurityTracks/pt_1/HitProperties/Strip/NumberOfRecHitsPerTrack_Strip_GenTk"
dqmcrawl offline_runs.txt --resource "/Tracking/TrackParameters/highPurityTracks/pt_1/HitProperties/Pixel/NumberOfRecHitsPerTrack_Pixel_GenTk"

## 06 - Number of Seeds (pp collisions)
dqmcrawl offline_runs.txt --resource "/Tracking/TrackParameters/generalTracks/TrackBuilding/NumberOfSeeds_initialStepSeeds_initialStep"
dqmcrawl offline_runs.txt --resource "/Tracking/TrackParameters/generalTracks/TrackBuilding/NumberOfSeeds_lowPtTripletStepSeeds_lowPtTripletStep"
dqmcrawl offline_runs.txt --resource "/Tracking/TrackParameters/generalTracks/TrackBuilding/NumberOfSeeds_pixelPairStepSeeds_pixelPairStep"
dqmcrawl offline_runs.txt --resource "/Tracking/TrackParameters/generalTracks/TrackBuilding/NumberOfSeeds_detachedTripletStepSeeds_detachedTripletStep"
dqmcrawl offline_runs.txt --resource "/Tracking/TrackParameters/generalTracks/TrackBuilding/NumberOfSeeds_mixedTripletStepSeeds_mixedTripletStep"
dqmcrawl offline_runs.txt --resource "/Tracking/TrackParameters/generalTracks/TrackBuilding/NumberOfSeeds_pixelLessStepSeeds_pixelLessStep"
dqmcrawl offline_runs.txt --resource "/Tracking/TrackParameters/generalTracks/TrackBuilding/NumberOfSeeds_tobTecStepSeeds_tobTecStep"

## Rate of Pixel Events by BX
dqmcrawl offline_runs.txt --resource "/PixelPhase1/Phase1_MechanicalView/eventrate_per_BX"

## **TProfile** !!! N dead ROCs
dqmcrawl offline_runs.txt --resource "/PixelPhase1/deadRocTotal"

## PixelPhas1 Digi ADC Barrel
dqmcrawl offline_runs.txt --resource "/PixelPhase1/Phase1_MechanicalView/num_digis_PXBarrel"
dqmcrawl offline_runs.txt --resource "/PixelPhase1/Phase1_MechanicalView/adc_PXBarrel"
dqmcrawl offline_runs.txt --resource "/PixelPhase1/Phase1_MechanicalView/num_digis_per_LumiBlock_PXBarrel"
dqmcrawl offline_runs.txt --resource "/PixelPhase1/Phase1_MechanicalView/adc_per_LumiBlock_PXBarrel"

## PixelPhas1 Digi ADC Endcap
dqmcrawl offline_runs.txt --resource "/PixelPhase1/Phase1_MechanicalView/num_digis_PXForward"
dqmcrawl offline_runs.txt --resource "/PixelPhase1/Phase1_MechanicalView/adc_PXForward"
dqmcrawl offline_runs.txt --resource "/PixelPhase1/Phase1_MechanicalView/num_digis_per_LumiBlock_PXForward"
dqmcrawl offline_runs.txt --resource "/PixelPhase1/Phase1_MechanicalView/adc_per_LumiBlock_PXForward"

## PixelPhase1 Cluster Number
dqmcrawl offline_runs.txt --resource "/PixelPhase1/Phase1_MechanicalView/num_clusters_PXBarrel"
dqmcrawl offline_runs.txt --resource "/PixelPhase1/Phase1_MechanicalView/num_clusters_PXForward"
dqmcrawl offline_runs.txt --resource "/PixelPhase1/Phase1_MechanicalView/num_clusters_per_LumiBlock_PXBarrel"
dqmcrawl offline_runs.txt --resource "/PixelPhase1/Phase1_MechanicalView/num_clusters_per_LumiBlock_PXForward"

## ntracks
dqmcrawl offline_runs.txt --resource "/PixelPhase1/Tracks/ntracks"
dqmcrawl offline_runs.txt --resource "/PixelPhase1/Tracks/ntracksinpixvolume"

## Charge and size
dqmcrawl offline_runs.txt --resource "/PixelPhase1/Tracks/charge_PXBarrel"
dqmcrawl offline_runs.txt --resource "/PixelPhase1/Tracks/charge_PXForward"
dqmcrawl offline_runs.txt --resource "/PixelPhase1/Tracks/size_PXBarrel"
dqmcrawl offline_runs.txt --resource "/PixelPhase1/Tracks/size_PXForward"

## Cluster on track charge per Inner
dqmcrawl offline_runs.txt --resource "/PixelPhase1/Tracks/PXBarrel/chargeInner_PXLayer_1"
dqmcrawl offline_runs.txt --resource "/PixelPhase1/Tracks/PXBarrel/chargeInner_PXLayer_2"
dqmcrawl offline_runs.txt --resource "/PixelPhase1/Tracks/PXBarrel/chargeInner_PXLayer_3"
dqmcrawl offline_runs.txt --resource "/PixelPhase1/Tracks/PXBarrel/chargeInner_PXLayer_4"

## Cluster on track charge per Outer
dqmcrawl offline_runs.txt --resource "/PixelPhase1/Tracks/PXBarrel/chargeOuter_PXLayer_1"
dqmcrawl offline_runs.txt --resource "/PixelPhase1/Tracks/PXBarrel/chargeOuter_PXLayer_2"
dqmcrawl offline_runs.txt --resource "/PixelPhase1/Tracks/PXBarrel/chargeOuter_PXLayer_3"
dqmcrawl offline_runs.txt --resource "/PixelPhase1/Tracks/PXBarrel/chargeOuter_PXLayer_4"

## Cluster charge (on-track) per Disk
dqmcrawl offline_runs.txt --resource "/PixelPhase1/Tracks/PXForward/charge_PXDisk_+1"
dqmcrawl offline_runs.txt --resource "/PixelPhase1/Tracks/PXForward/charge_PXDisk_+2"
dqmcrawl offline_runs.txt --resource "/PixelPhase1/Tracks/PXForward/charge_PXDisk_+3"
dqmcrawl offline_runs.txt --resource "/PixelPhase1/Tracks/PXForward/charge_PXDisk_-1"
dqmcrawl offline_runs.txt --resource "/PixelPhase1/Tracks/PXForward/charge_PXDisk_-2"
dqmcrawl offline_runs.txt --resource "/PixelPhase1/Tracks/PXForward/charge_PXDisk_-3"

## PixelPhase1 Residuals
dqmcrawl offline_runs.txt --resource "/PixelPhase1/Tracks/residual_x_PXBarrel"
dqmcrawl offline_runs.txt --resource "/PixelPhase1/Tracks/residual_x_PXForward"
dqmcrawl offline_runs.txt --resource "/PixelPhase1/Tracks/residual_y_PXBarrel"
dqmcrawl offline_runs.txt --resource "/PixelPhase1/Tracks/residual_y_PXForward"

## Cluster size (on-track) per
dqmcrawl offline_runs.txt --resource "/PixelPhase1/Tracks/PXBarrel/size_PXLayer_1"
dqmcrawl offline_runs.txt --resource "/PixelPhase1/Tracks/PXBarrel/size_PXLayer_2"
dqmcrawl offline_runs.txt --resource "/PixelPhase1/Tracks/PXBarrel/size_PXLayer_3"
dqmcrawl offline_runs.txt --resource "/PixelPhase1/Tracks/PXBarrel/size_PXLayer_4"

## Cluster size (on-track) per Disk
dqmcrawl offline_runs.txt --resource "/PixelPhase1/Tracks/PXForward/size_PXDisk_+1"
dqmcrawl offline_runs.txt --resource "/PixelPhase1/Tracks/PXForward/size_PXDisk_+2"
dqmcrawl offline_runs.txt --resource "/PixelPhase1/Tracks/PXForward/size_PXDisk_+3"
dqmcrawl offline_runs.txt --resource "/PixelPhase1/Tracks/PXForward/size_PXDisk_-1"
dqmcrawl offline_runs.txt --resource "/PixelPhase1/Tracks/PXForward/size_PXDisk_-2"
dqmcrawl offline_runs.txt --resource "/PixelPhase1/Tracks/PXForward/size_PXDisk_-3"

## FED Detected Errors Summary
dqmcrawl offline_runs.txt --resource "/SiStrip/ReadoutView/FED/nFEDErrors"
dqmcrawl offline_runs.txt --resource "/SiStrip/ReadoutView/Fiber/nBadActiveChannelStatusBits"

## OnTrackCluster (StoN)
dqmcrawl offline_runs.txt --resource "/SiStrip/MechanicalView/TIB/Summary_ClusterStoNCorr_OnTrack__TIB"
dqmcrawl offline_runs.txt --resource "/SiStrip/MechanicalView/TOB/Summary_ClusterStoNCorr_OnTrack__TOB"
dqmcrawl offline_runs.txt --resource "/SiStrip/MechanicalView/TID/MINUS/Summary_ClusterStoNCorr_OnTrack__TID__MINUS"
dqmcrawl offline_runs.txt --resource "/SiStrip/MechanicalView/TID/PLUS/Summary_ClusterStoNCorr_OnTrack__TID__PLUS"
dqmcrawl offline_runs.txt --resource "/SiStrip/MechanicalView/TEC/MINUS/Summary_ClusterStoNCorr_OnTrack__TEC__MINUS"
dqmcrawl offline_runs.txt --resource "/SiStrip/MechanicalView/TEC/PLUS/Summary_ClusterStoNCorr_OnTrack__TEC__PLUS"

## OffTrackCluster (Total Number)
dqmcrawl offline_runs.txt --resource "/SiStrip/MechanicalView/TIB/Summary_TotalNumberOfClusters_OffTrack__TIB"
dqmcrawl offline_runs.txt --resource "/SiStrip/MechanicalView/TOB/Summary_TotalNumberOfClusters_OffTrack__TOB"
dqmcrawl offline_runs.txt --resource "/SiStrip/MechanicalView/TID/MINUS/Summary_TotalNumberOfClusters_OffTrack__TID__MINUS"
dqmcrawl offline_runs.txt --resource "/SiStrip/MechanicalView/TID/PLUS/Summary_TotalNumberOfClusters_OffTrack__TID__PLUS"
dqmcrawl offline_runs.txt --resource "/SiStrip/MechanicalView/TEC/MINUS/Summary_TotalNumberOfClusters_OffTrack__TEC__MINUS"
dqmcrawl offline_runs.txt --resource "/SiStrip/MechanicalView/TEC/PLUS/Summary_TotalNumberOfClusters_OffTrack__TEC__PLUS"

## 02a - Tracks (pp collisions)
dqmcrawl online_runs.txt --resource "/Tracking/TrackParameters/GeneralProperties/NumberOfTracks_GenTk"
dqmcrawl online_runs.txt --resource "/Tracking/TrackParameters/HitProperties/NumberOfRecHitsPerTrack_GenTk"
dqmcrawl online_runs.txt --resource "/Tracking/TrackParameters/GeneralProperties/TrackPt_ImpactPoint_GenTk"
dqmcrawl online_runs.txt --resource "/Tracking/TrackParameters/GeneralProperties/Chi2oNDF_GenTk"
dqmcrawl online_runs.txt --resource "/Tracking/TrackParameters/GeneralProperties/TrackPhi_ImpactPoint_GenTk"
dqmcrawl online_runs.txt --resource "/Tracking/TrackParameters/GeneralProperties/TrackEta_ImpactPoint_GenTk"

## 02b - Total Hits Strip and Pixel (pp)
dqmcrawl online_runs.txt --resource "/Tracking/TrackParameters/HitProperties/Strip/NumberOfRecHitsPerTrack_Strip_GenTk"
dqmcrawl online_runs.txt --resource "/Tracking/TrackParameters/HitProperties/Pixel/NumberOfRecHitsPerTrack_Pixel_GenTk"

## Rate of Pixel Events by BX
dqmcrawl online_runs.txt --resource "/PixelPhase1/Phase1_MechanicalView/eventrate_per_BX"

## PixelPhas1 Digi ADC Barrel
dqmcrawl online_runs.txt --resource "/PixelPhase1/Phase1_MechanicalView/num_digis_PXBarrel"
dqmcrawl online_runs.txt --resource "/PixelPhase1/Phase1_MechanicalView/adc_PXBarrel"

## PixelPhas1 Digi ADC Endcap
dqmcrawl online_runs.txt --resource "/PixelPhase1/Phase1_MechanicalView/num_digis_PXForward"
dqmcrawl online_runs.txt --resource "/PixelPhase1/Phase1_MechanicalView/adc_PXForward"

## PixelPhase1 Cluster Number
dqmcrawl online_runs.txt --resource "/PixelPhase1/Phase1_MechanicalView/num_clusters_PXBarrel"
dqmcrawl online_runs.txt --resource "/PixelPhase1/Phase1_MechanicalView/num_clusters_PXForward"

## ntracks
dqmcrawl online_runs.txt --resource "/PixelPhase1/Tracks/ntracks"
dqmcrawl online_runs.txt --resource "/PixelPhase1/Tracks/ntracksinpixvolume"

## Charge and size
dqmcrawl online_runs.txt --resource "/PixelPhase1/Tracks/charge_PXBarrel"
dqmcrawl online_runs.txt --resource "/PixelPhase1/Tracks/charge_PXForward"
dqmcrawl online_runs.txt --resource "/PixelPhase1/Tracks/size_PXBarrel"
dqmcrawl online_runs.txt --resource "/PixelPhase1/Tracks/size_PXForward"

## Cluster on track charge per Inner
dqmcrawl online_runs.txt --resource "/PixelPhase1/Tracks/PXBarrel/chargeInner_PXLayer_1"
dqmcrawl online_runs.txt --resource "/PixelPhase1/Tracks/PXBarrel/chargeInner_PXLayer_2"
dqmcrawl online_runs.txt --resource "/PixelPhase1/Tracks/PXBarrel/chargeInner_PXLayer_3"
dqmcrawl online_runs.txt --resource "/PixelPhase1/Tracks/PXBarrel/chargeInner_PXLayer_4"

## Cluster on track charge per Outer
dqmcrawl online_runs.txt --resource "/PixelPhase1/Tracks/PXBarrel/chargeOuter_PXLayer_1"
dqmcrawl online_runs.txt --resource "/PixelPhase1/Tracks/PXBarrel/chargeOuter_PXLayer_2"
dqmcrawl online_runs.txt --resource "/PixelPhase1/Tracks/PXBarrel/chargeOuter_PXLayer_3"
dqmcrawl online_runs.txt --resource "/PixelPhase1/Tracks/PXBarrel/chargeOuter_PXLayer_4"

## Cluster charge (on-track) per Disk
dqmcrawl online_runs.txt --resource "/PixelPhase1/Tracks/PXForward/charge_PXDisk_+1"
dqmcrawl online_runs.txt --resource "/PixelPhase1/Tracks/PXForward/charge_PXDisk_+2"
dqmcrawl online_runs.txt --resource "/PixelPhase1/Tracks/PXForward/charge_PXDisk_+3"
dqmcrawl online_runs.txt --resource "/PixelPhase1/Tracks/PXForward/charge_PXDisk_-1"
dqmcrawl online_runs.txt --resource "/PixelPhase1/Tracks/PXForward/charge_PXDisk_-2"
dqmcrawl online_runs.txt --resource "/PixelPhase1/Tracks/PXForward/charge_PXDisk_-3"

## PixelPhase1 Residuals
dqmcrawl online_runs.txt --resource "/PixelPhase1/Tracks/residual_x_PXBarrel"
dqmcrawl online_runs.txt --resource "/PixelPhase1/Tracks/residual_x_PXForward"
dqmcrawl online_runs.txt --resource "/PixelPhase1/Tracks/residual_y_PXBarrel"
dqmcrawl online_runs.txt --resource "/PixelPhase1/Tracks/residual_y_PXForward"

## Cluster size (on-track) per
dqmcrawl online_runs.txt --resource "/PixelPhase1/Tracks/PXBarrel/size_PXLayer_1"
dqmcrawl online_runs.txt --resource "/PixelPhase1/Tracks/PXBarrel/size_PXLayer_2"
dqmcrawl online_runs.txt --resource "/PixelPhase1/Tracks/PXBarrel/size_PXLayer_3"
dqmcrawl online_runs.txt --resource "/PixelPhase1/Tracks/PXBarrel/size_PXLayer_4"

## Cluster size (on-track) per Disk
dqmcrawl online_runs.txt --resource "/PixelPhase1/Tracks/PXForward/size_PXDisk_+1"
dqmcrawl online_runs.txt --resource "/PixelPhase1/Tracks/PXForward/size_PXDisk_+2"
dqmcrawl online_runs.txt --resource "/PixelPhase1/Tracks/PXForward/size_PXDisk_+3"
dqmcrawl online_runs.txt --resource "/PixelPhase1/Tracks/PXForward/size_PXDisk_-1"
dqmcrawl online_runs.txt --resource "/PixelPhase1/Tracks/PXForward/size_PXDisk_-2"
dqmcrawl online_runs.txt --resource "/PixelPhase1/Tracks/PXForward/size_PXDisk_-3"


## FED Detected Errors Summary
dqmcrawl online_runs.txt --resource "/SiStrip/ReadoutView/FED/nFEDErrors"
dqmcrawl online_runs.txt --resource "/SiStrip/ReadoutView/Fiber/nBadActiveChannelStatusBits"

## OnTrackCluster (StoN)
dqmcrawl online_runs.txt --resource "/SiStrip/MechanicalView/TIB/Summary_ClusterStoNCorr_OnTrack__TIB"
dqmcrawl online_runs.txt --resource "/SiStrip/MechanicalView/TOB/Summary_ClusterStoNCorr_OnTrack__TOB"
dqmcrawl online_runs.txt --resource "/SiStrip/MechanicalView/TID/MINUS/Summary_ClusterStoNCorr_OnTrack__TID__MINUS"
dqmcrawl online_runs.txt --resource "/SiStrip/MechanicalView/TID/PLUS/Summary_ClusterStoNCorr_OnTrack__TID__PLUS"
dqmcrawl online_runs.txt --resource "/SiStrip/MechanicalView/TEC/MINUS/Summary_ClusterStoNCorr_OnTrack__TEC__MINUS"
dqmcrawl online_runs.txt --resource "/SiStrip/MechanicalView/TEC/PLUS/Summary_ClusterStoNCorr_OnTrack__TEC__PLUS"

## OffTrackCluster (Total Number)
dqmcrawl online_runs.txt --resource "/SiStrip/MechanicalView/TIB/Summary_TotalNumberOfClusters_OffTrack__TIB"
dqmcrawl online_runs.txt --resource "/SiStrip/MechanicalView/TOB/Summary_TotalNumberOfClusters_OffTrack__TOB"
dqmcrawl online_runs.txt --resource "/SiStrip/MechanicalView/TID/MINUS/Summary_TotalNumberOfClusters_OffTrack__TID__MINUS"
dqmcrawl online_runs.txt --resource "/SiStrip/MechanicalView/TID/PLUS/Summary_TotalNumberOfClusters_OffTrack__TID__PLUS"
dqmcrawl online_runs.txt --resource "/SiStrip/MechanicalView/TEC/MINUS/Summary_TotalNumberOfClusters_OffTrack__TEC__MINUS"
dqmcrawl online_runs.txt --resource "/SiStrip/MechanicalView/TEC/PLUS/Summary_TotalNumberOfClusters_OffTrack__TEC__PLUS"

# OMS
wbmcrawl --runs $FIRST_RUN_NUMBER $LAST_RUN_NUMBER
wbmcrawl --fills $FIRST_FILL_NUMBER $LAST_FILL_NUMBER
