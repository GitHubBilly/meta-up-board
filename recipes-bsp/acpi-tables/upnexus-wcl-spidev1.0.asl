/*
 * UP Nexus WCL (Wildcat Lake): spidev on SPI0 CS0.
 *
 * Content matches pc00.spi0.spidev1.0.asl (up-xtreme-i14 path \_SB.PC00.SPI0,
 * Shared). Kept as a board-specific file so future i14 SPI changes do not
 * silently affect WCL. Verified on hardware 2026-10-12: /dev/spidev0.0.
 * DSDT evidence: docs/up-nexus-wcl/ (BIOS exposes \_SB.PC00.SPI0).
 */
DefinitionBlock ("", "SSDT", 5, "INTEL", "SPIDEV0", 0x00000001)
{
    External (_SB.PC00.SPI0, DeviceObj)

    Scope (\_SB.PC00.SPI0)
    {
        Device (TP0)
        {
            Name (_HID, "SPT0001")  // _HID: Hardware ID
            Name (_DDN, "SPI test device connected to CS0")  // _DDN: DOS Device Name
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                SpiSerialBusV2 (0x0000, PolarityLow, FourWireMode, 0x08,
                    ControllerInitiated, 0x000F4240, ClockPolarityLow,
                    ClockPhaseFirst, "\\_SB.PC00.SPI0",
                    0x00, ResourceConsumer, , Shared,
                    )
            })
        }
    }
}
