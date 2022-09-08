Roslauch Dependecy Checker Action
=================================
## Description

This actions looks recursively in a path inside any ros based image and looks recursively for launch files, checking that their dependencies and any common syntax errors they may have.

## Inputs

|Name|Description|Mandatory|
-----|-----------|----------
`scripts-path`|Path to copy and run the validation scripts inside the image|:x:
`image-name`|Name of the image to check|:heavy_check_mark:
`env-setup-path`|Absolute path to the ROS environment script inside the image|:heavy_check_mark:
`checking-path`|Absolute path to look recursively for ROS launch files to check inside the image|:heavy_check_mark:
`checking-excludes`|Expressions to evaluate in order to exclude them from the checking directory and its subdirectories|:x:

> ### :memo: **Note:**
> The excludes can be separated by spaces or new lines in the action call. See examples bellow. Also, excludes can be any valid expression, like relative paths, absolute paths, paths with blobbing or plain strings.

## Examples

### Example with exclusions

```
- name: Check dependencies
  uses: rapyuta-robotics/rr_action_roslauch_dependecy_checker@1.1.0
  with:
    image-name: my-build-image
    env-setup-path: /catkin/ws/install/setup.bash
    checking-path: /some/absolute/path/to/src
    checking-excludes: |
      a-whole-folder/*
      /an/absolute/path
      a/relative/path
      *this-particular-expression*
```

### Example withot exclusions

```
- name: Check dependencies
  uses: rapyuta-robotics/rr_action_roslauch_dependecy_checker@1.1.0
  with:
    image-name: my-build-image
    env-setup-path: /my/catkin/ws/install/setup.bash
    checking-path: /another/absolute/path/to/src
```
