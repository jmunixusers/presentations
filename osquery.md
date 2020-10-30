# osquery

## What is osquery?

osquery allows you to query your operating system using SQL to explore system
data.

## How do I get started?

You can download osquery from their [downloads page.](https://osquery.io/downloads/)
Once you get everything set up, including getting the `osqueryd` daemon running
(You may need to look into the [documentation](https://osquery.readthedocs.io/en/stable/)
for this), you're almost ready to start writing queries!

Start the interactive osquery console, `osqueryi`

## What queries could I write?

First, you may want to look at the tables that osquery has available on their
[website.](https://osquery.io/schema/) Note that some of these tables are
exclusive to specific operating systems. Also, you can see a list of tables that
are available to you by typing `.tables` into the interactive shell. You can see the
available columns for a table within the interactive shell by typing `.schema table_name`
into the interactive shell. Queries are written in SQL and you may have as many clauses
as you like, just be sure to terminate your query with a semicolon. Lets get started with
a query to see information about our memory. This table can only be used on Linux.

```sql
SELECT *
FROM memory_info;
```

Well that's cool, but you probably don't care about half of that information, and
you probably don't want to convert bytes into something meaningful in your head.

```sql
SELECT
  (memory_total / POWER(2, 30))
  AS 'Total memory (GiB)',
  (memory_free / POWER(2, 30))
  AS 'Free memory (GiB)'
FROM memory_info;
```

## If I write a query for one OS, could I use it on another OS as well?

Yes! As long as the table that you're writing the query for is available for
both operating systems. For example, here's a couple queries that can be used
on any platform.

View all users:

```sql
SELECT username, type
FROM users;
```

View all listening ports:

```sql
SELECT *
FROM listening_ports;
```

View OS information:

```sql
SELECT name, version, major,
  platform, platform_like
FROM os_version;
```

View processes without an executable on the disk:

```sql
SELECT pid, name, path
FROM processes
WHERE on_disk = 0;
```

## What else can osquery do?

* Install extensions to give osquery some extra capabilities
* Schedule queries to monitor your operating system
* Monitor file integrity
