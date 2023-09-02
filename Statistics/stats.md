## Setting the statistics on which gives us the execution time from the CPU and how many rows got retrieved and so on.

SET STATISTICS IO ON;
GO

## Getting the Actual Execution Plan in a different ways:

#### First:

SET STATISTICS XML ON;
GO
SET STATISTICS XML OFF;
GO

#### Second: Enable the actual plan through the UI.

SET STATISTICS TIME ON;
GO
SET STATISTICS TIME OFF;
GO

## Extended Events:
- sql_statement_completed
- sp_statement_completed
- rpc_completed
- sql_batch_completed

## Really expensive events:
- query_post_compilation_showplan
- query_post_execution_showplan
- query_pre_execution_showplan

## Dynamic Management Objects
- sys.dm_exec_sql_text
- sys.dm_exec_query_plan
- sys.dm_exec_cached_plans
- sys.dm_exec_text_query_plan
#### Seeing aggregation statistics
- sys.dm_exec_query_stats
- sys.dm_exec_function_stats

## Performance Monitor:
- CPU - 100% of a CPU?
- Memory - Memory left
- Physical Disk - Disk latency
- Access Methods - What I have in terms of scans and seeks?
- Locks - If we have atypical or extended locks being taken.
  - Establish a baseline for your system.
- SQL Statistics - Patch Request Per Second, Compilations Per Second, and Recompilations Per Second.
