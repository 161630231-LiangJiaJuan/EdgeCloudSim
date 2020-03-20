#!/bin/sh

script_root_path="$(dirname "$(readlink -f "$0")")"
simulation_out_folder=$1
scenario_name=$2
edge_devices_file=$3
applications_file=$4
iteration_number=$5

#这是成功的版本，当shell脚本通过cygwin运行时，会出现一些无法识别路径的问题，这个时候我们利用cygpath -pw进行处理
##JAVA_HOME='/cygdrive/c/Program Files/Java/jdk1.8.0_131'
CLASSPATH=../../bin:../../lib/cloudsim-4.0.jar:../../lib/commons-math3-3.6.1.jar:../../lib/colt.jar
scenario_out_folder=$(cygpath -pw "${simulation_out_folder}/${scenario_name}/ite${iteration_number}")
scenario_conf_file=$(cygpath -pw "${script_root_path}/config/${scenario_name}.properties")
scenario_edge_devices_file=$(cygpath -pw "${script_root_path}/config/${edge_devices_file}")
scenario_applications_file=$(cygpath -pw "${script_root_path}/config/${applications_file}")


mkdir -p $scenario_out_folder
java -cp "$(cygpath -pw "$CLASSPATH")" edu.boun.edgecloudsim.applications.sample_app2.MainApp $scenario_conf_file $scenario_edge_devices_file $scenario_applications_file $scenario_out_folder $iteration_number > ${scenario_out_folder}.log
                                                                                         
tar -czf ${scenario_out_folder}.tar.gz -C $simulation_out_folder/${scenario_name} ite${iteration_number}
#rm -rf $scenario_out_folder
