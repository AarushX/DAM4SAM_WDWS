@ECHO OFF
SET "CMD=wget --secure-protocol=TLSv1_2"

REM choco install wget <-- you may need to do this if wget < 1.15

WHERE wget >nul 2>nul
IF %ERRORLEVEL% EQU 0 (
    SET "CMD=wget"
) ELSE (
    WHERE curl >nul 2>nul
    IF %ERRORLEVEL% EQU 0 (
        SET "CMD=curl -L -O"
    )
)

IF NOT DEFINED CMD (
    ECHO Please install wget or curl to download the checkpoints.
    EXIT /B 1
)

SET "SAM2p1_BASE_URL=https://dl.fbaipublicfiles.com/segment_anything_2/092824"
SET "sam2p1_hiera_t_url=%SAM2p1_BASE_URL%/sam2.1_hiera_tiny.pt"
SET "sam2p1_hiera_s_url=%SAM2p1_BASE_URL%/sam2.1_hiera_small.pt"
SET "sam2p1_hiera_b_plus_url=%SAM2p1_BASE_URL%/sam2.1_hiera_base_plus.pt"
SET "sam2p1_hiera_l_url=%SAM2p1_BASE_URL%/sam2.1_hiera_large.pt"

ECHO Downloading sam2.1_hiera_tiny.pt checkpoint...
%CMD% %sam2p1_hiera_t_url%
IF ERRORLEVEL 1 (
    ECHO Failed to download checkpoint from %sam2p1_hiera_t_url%
    EXIT /B 1
)

ECHO Downloading sam2.1_hiera_small.pt checkpoint...
%CMD% %sam2p1_hiera_s_url%
IF ERRORLEVEL 1 (
    ECHO Failed to download checkpoint from %sam2p1_hiera_s_url%
    EXIT /B 1
)

ECHO Downloading sam2.1_hiera_base_plus.pt checkpoint...
%CMD% %sam2p1_hiera_b_plus_url%
IF ERRORLEVEL 1 (
    ECHO Failed to download checkpoint from %sam2p1_hiera_b_plus_url%
    EXIT /B 1
)

ECHO Downloading sam2.1_hiera_large.pt checkpoint...
%CMD% %sam2p1_hiera_l_url%
IF ERRORLEVEL 1 (
    ECHO Failed to download checkpoint from %sam2p1_hiera_l_url%
    EXIT /B 1
)

ECHO All checkpoints are downloaded successfully.
EXIT /B 0
