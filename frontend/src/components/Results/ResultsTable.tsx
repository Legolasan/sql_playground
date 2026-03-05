import { usePlaygroundStore } from '../../store/store'
import { AlertCircle, CheckCircle, Clock } from 'lucide-react'

export default function ResultsTable() {
  const { results, isExecuting } = usePlaygroundStore()

  if (isExecuting) {
    return (
      <div className="flex items-center justify-center h-48 text-gray-500">
        <div className="flex items-center gap-3">
          <div className="animate-spin rounded-full h-6 w-6 border-b-2 border-sql-accent"></div>
          <span>Executing query...</span>
        </div>
      </div>
    )
  }

  if (!results) {
    return (
      <div className="flex items-center justify-center h-48 text-gray-500">
        <p>Run a query to see results</p>
      </div>
    )
  }

  if (!results.success) {
    return (
      <div className="p-4">
        <div className="flex items-start gap-3 p-4 bg-red-900/20 border border-red-800 rounded-lg">
          <AlertCircle className="text-red-500 flex-shrink-0 mt-0.5" size={20} />
          <div>
            <h4 className="font-medium text-red-400">Query Error</h4>
            <pre className="mt-2 text-sm text-red-300 whitespace-pre-wrap font-mono">
              {results.error}
            </pre>
          </div>
        </div>
      </div>
    )
  }

  return (
    <div className="flex flex-col h-full">
      {/* Stats bar */}
      <div className="flex items-center gap-4 px-4 py-2 bg-gray-800/50 border-b border-gray-700 text-sm">
        <div className="flex items-center gap-2 text-green-400">
          <CheckCircle size={14} />
          <span>Success</span>
        </div>
        <div className="flex items-center gap-2 text-gray-400">
          <Clock size={14} />
          <span>{results.execution_time_ms}ms</span>
        </div>
        <div className="text-gray-400">
          {results.row_count} row{results.row_count !== 1 ? 's' : ''}
        </div>
      </div>

      {/* Results table */}
      <div className="flex-1 overflow-auto">
        {results.rows.length === 0 ? (
          <div className="flex items-center justify-center h-32 text-gray-500">
            Query executed successfully. No rows returned.
          </div>
        ) : (
          <table className="results-table">
            <thead>
              <tr>
                {results.columns.map((col, i) => (
                  <th key={i}>{col}</th>
                ))}
              </tr>
            </thead>
            <tbody>
              {results.rows.map((row, rowIndex) => (
                <tr key={rowIndex}>
                  {row.map((cell, cellIndex) => (
                    <td key={cellIndex}>
                      {cell === null ? (
                        <span className="text-gray-600 italic">NULL</span>
                      ) : typeof cell === 'boolean' ? (
                        cell ? 'true' : 'false'
                      ) : (
                        String(cell)
                      )}
                    </td>
                  ))}
                </tr>
              ))}
            </tbody>
          </table>
        )}
      </div>
    </div>
  )
}
