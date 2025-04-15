rule registration:
    input:
        post_ct=bids(
            root=config["bids_dir"],
            suffix="ct",
            datatype="ct",
            session="post",
            acq="Electrode",
            extension=".nii.gz",
            **inputs["post_ct"].wildcards,
        ),
        fixed_t1w = bids(
            root=config["bids_dir"],
            suffix="T1w",
            session="pre",
            run="02",
            datatype="anat",
            extension=".nii.gz",
            **inputs["pre_t1w"].wildcards,
        ),
    output:
        xfm_slicer=bids(
            root=config["output_dir"],
            datatype="registration",
            space="native",
            suffix="slicer.mat",
            **inputs["post_ct"].wildcards,
        ),
        xfm_ras=bids(
            root=config["output_dir"],
            datatype="registration",
            space="native",
            suffix="xfm.txt",
            **inputs["post_ct"].wildcards,
        ),
        out_im=bids(
            root=config["output_dir"],
            datatype="registration",
            space="native",
            suffix="MNI.nii.gz",
            **inputs["post_ct"].wildcards,
        ),
    script:
        "../scripts/regis_script.py"