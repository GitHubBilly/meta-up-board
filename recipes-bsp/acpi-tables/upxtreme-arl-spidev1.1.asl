/*
 * UP Xtreme ARL (UPX-ARL01): spidev on SPI0 CS1 (path \_SB.PC00.SPI0).
 * Verified against live board firmware_node path and Ubuntu acpi-upgrades.
 */
DefinitionBlock ("", "SSDT", 5, "INTEL", "SPIDEV1", 0x00000001)
{
    External (_SB.PC00.SPI0, DeviceObj)

    Scope (\_SB.PC00.SPI0)
    {
        Device (TP1)
        {
            Name (_HID, "SPT0001")  // _HID: Hardware ID
            Name (_DDN, "SPI test device connected to CS1")  // _DDN: DOS Device Name
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                SpiSerialBusV2 (0x0001, PolarityLow, FourWireMode, 0x08,
                    ControllerInitiated, 0x000F4240, ClockPolarityLow,
                    ClockPhaseFirst, "\\_SB.PC00.SPI0",
                    0x00, ResourceConsumer, , Shared,
                    )
            })
        }
    }
}
