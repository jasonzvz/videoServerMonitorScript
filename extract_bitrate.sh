Original_camera_bitrate_file=$1
Original_online_camera_file=$2
Camera_videoServer_mapping_file=$3
Current_target_videoServer=$4
CameraId_list_array="./tmp/cameraIdList.txt"
cameraList=`jq 'keys' $Original_camera_bitrate_file`
echo "$cameraList" > $CameraId_list_array
cameraNumber=`echo $cameraList | jq 'length'`
for i in $(seq 0 $((cameraNumber-1)))
do
	cmd="jq '.[$i]' $CameraId_list_array"
	currentCamera=`eval $cmd | tr -d '"'`
	cmd="jq '.[\"$currentCamera\"] | .[-1:] | .[] | .[1]' $Original_camera_bitrate_file"
	currentCameraBitrate=`eval $cmd`
	currentCameraBitrate_rounded=`printf %0.f $currentCameraBitrate`
	b_online=`grep -i $currentCamera $Original_online_camera_file | wc -l`
	if [ $b_online != 0 ] || [ $currentCameraBitrate != 0 ]; then
		if [ `grep $currentCamera $Camera_videoServer_mapping_file | cut -d " " -f2` == $Current_target_videoServer ]; then
			printf '%-15s \t%-15s\n' $currentCamera $currentCameraBitrate_rounded
		fi
	fi
done
