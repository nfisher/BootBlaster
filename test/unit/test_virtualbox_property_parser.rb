require 'test/unit'
require 'mocha'
require 'virtual_box_parser'

class VirtualBoxPropertyParserTest < Test::Unit::TestCase

	def test_parse_detailed_vminfo_should_extract_the_expected_number_of_properties
		receiver = mock()
		receiver.expects(:receive_virtualbox_vminfo).once().with() { |value| value.class == Hash and value['ostype'] == 'RedHat' }

		instance = VirtualBoxPropertyParser.new
		instance.parse_detailed_vminfo(sample_config_io)
		instance.tell_vminfo(receiver)
	end

	def test_reset_clears_vminfo
		receiver = mock()
		receiver.expects(:receive_vminfo).never
		instance = VirtualBoxPropertyParser.new
		instance.parse_detailed_vminfo(sample_config_io)
		instance.reset
		instance.tell_vminfo(receiver)
	end


# VBoxManage showvminfo --machinereadable --details 0fc20e1b-d21f-40b4-b13c-69d1438503fb
	SAMPLE_CONFIG=<<-"EOT"
name="Centos5.7"
ostype="RedHat"
UUID="0fc20e1b-d21f-40b4-b13c-69d1438503fb"
CfgFile="/Users/nfisher/VirtualBox VMs/Centos5.7/Centos5.7.vbox"
SnapFldr="/Users/nfisher/VirtualBox VMs/Centos5.7/Snapshots"
LogFldr="/Users/nfisher/VirtualBox VMs/Centos5.7/Logs"
hardwareuuid="0fc20e1b-d21f-40b4-b13c-69d1438503fb"
memory=380
pagefusion="off"
vram=12
cpuexecutioncap=100
hpet="off"
chipset="piix3"
firmware="BIOS"
cpus=1
synthcpu="off"
bootmenu="messageandmenu"
boot1="floppy"
boot2="dvd"
boot3="disk"
boot4="none"
acpi="on"
ioapic="on"
pae="on"
biossystemtimeoffset=0
rtcuseutc="on"
hwvirtex="on"
hwvirtexexcl="off"
nestedpaging="on"
largepages="on"
vtxvpid="on"
VMState="poweroff"
VMStateChangeTime="2012-02-12T11:51:46.000000000"
monitorcount=1
accelerate3d="off"
accelerate2dvideo="off"
teleporterenabled="off"
teleporterport=0
teleporteraddress=""
teleporterpassword=""
storagecontrollername0="IDE Controller"
storagecontrollertype0="PIIX4"
storagecontrollerinstance0="0"
storagecontrollermaxportcount0="2"
storagecontrollerportcount0="2"
storagecontrollerbootable0="on"
storagecontrollername1="SATA Controller"
storagecontrollertype1="IntelAhci"
storagecontrollerinstance1="0"
storagecontrollermaxportcount1="30"
storagecontrollerportcount1="1"
storagecontrollerbootable1="on"
"IDE Controller-0-0"="none"
"IDE Controller-0-1"="none"
"IDE Controller-1-0"="emptydrive"
"IDE Controller-IsEjected"="off"
"IDE Controller-1-1"="none"
"SATA Controller-0-0"="/Users/nfisher/VirtualBox VMs/Centos5.7/Centos5.7.vdi"
"SATA Controller-ImageUUID-0-0"="be8b7bf1-d50f-4810-b3a7-59bf1f9f7bae"
natnet1="nat"
macaddress1="08002717511C"
cableconnected1="on"
nic1="nat"
mtu="0"
sockSnd="64"
sockRcv="64"
tcpWndSnd="64"
tcpWndRcv="64"
nic2="none"
nic3="none"
nic4="none"
nic5="none"
nic6="none"
nic7="none"
nic8="none"
hidpointing="ps2mouse"
hidkeyboard="ps2kbd"
uart1="off"
uart2="off"
audio="coreaudio"
clipboard="bidirectional"
vrde="off"
usb="on"
VRDEActiveConnection="off"
VRDEClients=0
GuestMemoryBalloon=0
GuestOSType="RedHat"
GuestAdditionsRunLevel=0
	EOT

	def sample_config_io
		StringIO.new(SAMPLE_CONFIG)
	end
end

