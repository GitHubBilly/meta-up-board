# UP Nexus WCL — ACPI SPI path verification

Hardware dump used to confirm that the board-specific SSDT
`recipes-bsp/acpi-tables/upnexus-wcl-spidev1.0.asl` attaches to a real
controller path in the BIOS DSDT (not a silent no-op).

## Provenance

| Item | Value |
|------|--------|
| Board | UP Nexus WCL (Wildcat Lake / Intel Core Series 3) |
| Captured | 2026-10-13 |
| Source | `/sys/firmware/acpi/tables/DSDT` on running image |
| Binary | [`dsdt.dat`](dsdt.dat) (SHA-256 `2309e4d31fb042445e445a17e090db926a2fda43c9169d1853104b952308b5ac`) |
| Disassembly | [`dsdt.dsl`](dsdt.dsl) via `iasl -d dsdt.dat` (ACPICA) |
| OEM ID / Table ID | `ALASKA` / `A M I ` |
| DSDT length | 0x34A0A (215562 bytes) |

Re-disassemble if needed:

```bash
iasl -d docs/up-nexus-wcl/dsdt.dat
```

## Result

BIOS DSDT exposes **`\_SB.PC00.SPI0`** under `Scope (_SB.PC00)`:

- `Device (SPI0)` with `_ADR` = `0x001E0002`
- Later `Scope (_SB.PC00.SPI0)` power helpers also present
- `SPI1` / `SPI2` siblings exist; our SSDT uses **SPI0** only (same as up-xtreme-i14)

This matches `upnexus-wcl-spidev1.0.asl` (`External (_SB.PC00.SPI0)` +
`SpiSerialBusV2` … Shared). Runtime check (2026-10-12): `/dev/spidev0.0`
appeared after loading the SSDT.

## Excerpt (from `dsdt.dsl`)

```asl
/* Under Scope (_SB.PC00) — around line 11929 of dsdt.dsl */
Device (SPI0)
{
    /* … _DSM / _PS3 / _PS0 when SM00 … */
    Method (_ADR, 0, NotSerialized)
    {
        Return (0x001E0002)
    }
}

/* Also present later */
Scope (_SB.PC00.SPI0)
{
    Method (M0D3, 0, NotSerialized) { … }
    Method (M1D3, 0, NotSerialized) { … }
}
```

## Related machine conf

`conf/machine/up-nexus-wcl.conf`:

```bitbake
ACPI_TABLES ?= "upnexus-wcl-spidev1.0.asl"
```
