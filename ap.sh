#!/usr/bin/env tcsh

# created by uber_subject.py: version 1.2 (April 5, 2018)
# creation date: Mon Oct  1 23:54:19 2018

# set subject and group identifiers
set sub j= 02
set gname = sub-02
set session = test

# set data directories
set top_dir = /scratch/psyc5171/dataset1/sub-02/ses-test
set anat_dir = $top_dir/anat
set epi_dir = $top_dir/func


# run afni_proc.py to create a single subject processing script
afni_proc.py -subj_id sub-02                                                  \
        -script run_afni.sh -scr_overwrite                                    \
        -blocks tshift align tlrc volreg blur mask scale regress             \
        -copy_anat $anat_dir/sub-02_ses-test_T1w.nii.gz                          \
        -dsets $epi_dir/sub-02_ses-test_task-fingerfootlips_run-0*_bold.nii.gz            \
        -tcat_remove_first_trs 0   -tshift_opts_ts -tpattern alt+z          \
        -tlrc_base MNI_avg152T1+tlrc                                         \
        -volreg_align_to first                                               \
        -volreg_align_e2a                                                    \
        -volreg_tlrc_warp                                                    \
        -blur_size 6.0                                                       \
        -regress_stim_times                                                   \
            /scratch/psyc5171/eay15101/hw7/Finger.txt                           \
            /scratch/psyc5171/eay15101/hw7/Foot.txt                         \
            /scratch/psyc5171/eay15101/hw7/Lips.txt                       \
        -regress_stim_labels                                                 \
            Finger Foot Lips Hash Filler                                         \
        -regress_basis 'BLOCK(15)'                                                 \
        -regress_censor_motion 0.5                                           \
        -regress_apply_mot_types demean deriv                                \
        -regress_motion_per_run                                              \
        -regress_opts_3dD                                                    \
            -gltsym 'SYM: Finger -Foot' -glt_label 1 Finger-Foot \
            -gltsym 'SYM: Finger -Lips' -glt_label 2 Finger-Lips \
            -gltsym 'SYM: Foot -Lips' -glt_label 3 Foot-Lips  \
        -regress_make_ideal_sum sum_ideal.1D                                 \
        -regress_est_blur_epits                                              \
        -regress_est_blur_errts                                              \
        -regress_run_clustsim no

#regress stim labels: should be in same order as timing filesa re found...abc order
#regress basis GAM for event related and BLOCK(time) for blocked 
