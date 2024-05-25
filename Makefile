MQTT_DEMO_PATH      := AWS_MQTT_Demo
OUT_PATH            := Output
AVH_SIMLIMIT_TIME   := 800
SHELL 				:= /bin/bash

all: source clean build run

help:
	@echo "make help 	-> Show this help msg."
	@echo "make source 	-> Install env parameters."
	@echo "make build 	-> Build thie demo."
	@echo "make clean 	-> Clean object files."
	@echo "make run 	-> Run this demo."
	@echo "make debug 	-> Build & run this demo."
	@echo "make all 	-> Source & clean & build & run all together."
	@echo "make pip 	-> Install python tools by pip."

debug: build run

source:
	@echo "Copy and source .bashrc ..."
	@cp -rf .bashrc ~/.bashrc
	@source ~/.bashrc
	@echo "Copy CMSIS-Build-Utils.cmake ..."
	@sudo cp -rf CMake/CMSIS-Build-Utils.cmake /opt/ctools/etc/CMSIS-Build-Utils.cmake

build:
	@echo "Building ..."
	@test -e $(OUT_PATH) || mkdir -p $(OUT_PATH)
	cbuild --packs $(MQTT_DEMO_PATH)/AWS_MQTT_MutualAuth.VHT_MPS2_Cortex-M7.cprj --update-rte
	@cp -rf $(MQTT_DEMO_PATH)/Objects/image.elf $(OUT_PATH)

run:
	@echo "Running ..."
	/opt/VHT/bin/FVP_MPS2_Cortex-M7 --stat --simlimit $(AVH_SIMLIMIT_TIME) -f $(MQTT_DEMO_PATH)/vht_config.txt $(OUT_PATH)/image.elf

clean:
	@echo "Clean ..."
	rm -rf $(MQTT_DEMO_PATH)/Objects/
	rm -rf $(OUT_PATH)
	rm -rf aws_mqtt*.zip

pip:
	pip install -r $(MQTT_DEMO_PATH)/requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple

.PHONY: all source clean build run help