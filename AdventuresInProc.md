# Adventures in /proc

/proc is a bridge to read kernel data and configure parameters.

## Common Utilities
You can find many of the data sources that common utilities use.

- `/proc/cpuinfo` - `lscpu`
- `/proc/modules` - `lsmod`
- `/proc/mounts` - `mount`
- `/proc/version` - `uname`
- `/proc/net/tcp` and `/proc/net/dev` - `ip`, `netstat`, and `ifconfig`

## In-depth kernel data
You can also get far more in-depth data directly from the kernel.

- `/proc/meminfo`
- `/proc/cmdline`
- `/proc/kcore`

## Process statistics
Data on individual processes can be queried from `/proc/$PID` or `/proc/self`. Much of this data is available from flags to `ps` or `lsof`.

- `cmdline`
- `cwd` - symlink to the running binary
- `environ` - environment variables are NUL separated, use something like `tr \0 \n` to clean up
- `fd/` - directory of symlinks to open files
- `limits` - `ulimit` data
- `maps` - library addresses

## Interacting with the kernel
Some parameters can be modified directly through `/proc`, in addition to something like `sysctl`.

- `/proc/sys/vm/swappiness` - `sysctl -w vm.swappiness`
- `echo 3 > /proc/sys/vm/drop_caches` - drop filesystem cache
