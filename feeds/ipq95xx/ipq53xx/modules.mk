define KernelPackage/usb-dwc3-internal
  TITLE:=DWC3 USB controller driver
  DEPENDS:=+USB_GADGET_SUPPORT:kmod-usb-gadget
  KCONFIG:= \
        CONFIG_USB_DWC3 \
        CONFIG_USB_DWC3_HOST=n \
        CONFIG_USB_DWC3_GADGET=n \
        CONFIG_USB_DWC3_DUAL_ROLE=y \
        CONFIG_EXTCON=y \
        CONFIG_USB_DWC3_DEBUG=n \
        CONFIG_USB_DWC3_VERBOSE=n
  FILES:= $(LINUX_DIR)/drivers/usb/dwc3/dwc3.ko
  AUTOLOAD:=$(call AutoLoad,84,dwc3)
  $(call AddPlatformDepends/usb)
endef

define KernelPackage/usb-dwc3-internal/description
 This driver provides support for the Dual Role SuperSpeed
 USB Controller based on the Synopsys DesignWare USB3 IP Core
endef

$(eval $(call KernelPackage,usb-dwc3-internal))

define KernelPackage/usb-dwc3-qcom-internal
  TITLE:=DWC3 QTI USB driver
  DEPENDS:=@!LINUX_4_14 @(TARGET_ipq40xx||TARGET_ipq806x||TARGET_ipq807x||TARGET_ipq60xx||TARGET_ipq95xx||TARGET_ipq50xx||TARGET_ipq53xx) +kmod-usb-dwc3-internal
  KCONFIG:= CONFIG_USB_DWC3_QCOM
  FILES:= $(LINUX_DIR)/drivers/usb/dwc3/dwc3-qcom.ko
  AUTOLOAD:=$(call AutoLoad,83,dwc3-qcom)
  $(call AddPlatformDepends/usb)
endef

define KernelPackage/usb-dwc3-qcom-internal/description
 Some QTI SoCs use DesignWare Core IP for USB2/3 functionality.
 This driver also handles Qscratch wrapper which is needed for
 peripheral mode support.
endef

$(eval $(call KernelPackage,usb-dwc3-qcom-internal))

define KernelPackage/usb-phy-ipq807x
  TITLE:=DWC3 USB QTI PHY drivers for IPQ807x based targets
  DEPENDS:=@TARGET_ipq||TARGET_ipq807x||TARGET_ipq95xx||TARGET_ipq60xx
  KCONFIG:= \
        CONFIG_PHY_QCOM_QUSB2 \
        CONFIG_PHY_QCOM_QMP=y \
        CONFIG_USB_QCOM_QUSB_PHY \
        CONFIG_USB_QCOM_QMP_PHY
  FILES:= \
        $(LINUX_DIR)/drivers/phy/qualcomm/phy-qcom-qusb2.ko@ge5.4 \
        $(LINUX_DIR)/drivers/usb/phy/phy-msm-qusb.ko@le4.4 \
        $(LINUX_DIR)/drivers/usb/phy/phy-msm-ssusb-qmp.ko@le4.4
  AUTOLOAD:=$(call AutoLoad,85,phy-qcom-qusb2 phy-msm-qusb phy-msm-ssusb-qmp)
  $(call AddPlatformDepends/usb)
endef

define KernelPackage/usb-phy-ipq807x/description
  Support for USB PHY drivers in IPQ807x based SoCs.
endef

$(eval $(call KernelPackage,usb-phy-ipq807x))

define KernelPackage/diag-char
  TITLE:=CHAR DIAG
  KCONFIG:= CONFIG_DIAG_MHI=y@ge5.4 \
          CONFIG_DIAG_OVER_PCIE=n@ge5.4 \
          CONFIG_DIAGFWD_BRIDGE_CODE=y \
          CONFIG_DIAG_CHAR=m
  DEPENDS:=+kmod-lib-crc-ccitt
  FILES:=$(LINUX_DIR)/drivers/char/diag/diagchar.ko
endef

define KernelPackage/diag-char/description
 CHAR DIAG
endef

$(eval $(call KernelPackage,diag-char))

define KernelPackage/bootconfig
  SUBMENU:=Other modules
  TITLE:=Bootconfig partition for failsafe
  KCONFIG:=CONFIG_BOOTCONFIG_PARTITION
  FILES:=$(LINUX_DIR)/drivers/platform/ipq/bootconfig.ko@ge5.4
  AUTOLOAD:=$(call AutoLoad,56,bootconfig,1)
endef

define KernelPackage/bootconfig/description
  Bootconfig partition for failsafe
endef

$(eval $(call KernelPackage,bootconfig))

