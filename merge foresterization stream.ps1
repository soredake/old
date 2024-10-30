function merge_foresterization_stream {
  # cd to foresterization dir
  Push-Location $HOME\shared-oracle\foresterization

  # Create the output directory if it doesn't exist
  if (-not (Test-Path "output")) {
    New-Item -ItemType Directory -Path "output"
  }

  # Get the current date in a specific format (e.g., yyyy-MM-dd)
  $currentDate = Get-Date -Format "yyyy-MM-dd"
  $outputFileName = "foresterization_$currentDate.mkv"
  $outputFilePath = "output\$outputFileName"

  # Process each MP4 file to ensure the MOOV atom is at the start
  Get-ChildItem *.mp4 | ForEach-Object {
    $inputFile = $_.Name
    $outputFile = "output\$inputFile"
    ffmpeg -i $inputFile -c copy -movflags faststart $outputFile
  }

  # Generate the file list for concatenation
  Get-ChildItem output\*.mp4 | ForEach-Object { "file '$($_.FullName)'" } | Set-Content file_list.txt

  # Run FFmpeg to concatenate the files
  ffmpeg -f concat -safe 0 -i file_list.txt -c copy $outputFilePath

  # Delete the intermediate *.mp4 files in the output folder
  Remove-Item output\*.mp4

  # Delete the intermediate *.mp4 files in the output folder
  Remove-Item file_list.txt

  # Check if file is correctly muxed
  ffprobe -v error -show_entries format='format_name,duration' -of default=noprint_wrappers=1:nokey=1 $outputFilePath

  # Back to previous PWD
  Pop-Location
}
