import { usePlaygroundStore } from '../../store/store'
import { Info, Zap } from 'lucide-react'

export default function ExplainView() {
  const { explainResult } = usePlaygroundStore()

  if (!explainResult) {
    return null
  }

  return (
    <div className="p-4">
      <div className="flex items-center gap-2 mb-4">
        <Info className="text-sql-accent" size={20} />
        <h3 className="font-medium">Query Execution Plan</h3>
        {explainResult.total_cost && (
          <span className="ml-auto flex items-center gap-1 text-sm text-gray-400">
            <Zap size={14} className="text-yellow-500" />
            Total Cost: {explainResult.total_cost.toFixed(2)}
          </span>
        )}
      </div>

      {/* Text plan */}
      <div className="bg-gray-900 rounded-lg p-4 font-mono text-sm overflow-x-auto">
        <pre className="whitespace-pre text-gray-300">
          {explainResult.plan_text}
        </pre>
      </div>

      {/* Tips */}
      <div className="mt-4 p-4 bg-blue-900/20 border border-blue-800 rounded-lg">
        <h4 className="font-medium text-blue-400 mb-2">Reading the Plan</h4>
        <ul className="text-sm text-blue-300 space-y-1">
          <li>
            <strong>Seq Scan</strong> - Full table scan (consider adding an index)
          </li>
          <li>
            <strong>Index Scan</strong> - Using an index (efficient)
          </li>
          <li>
            <strong>cost</strong> - Estimated startup..total cost
          </li>
          <li>
            <strong>rows</strong> - Estimated number of rows
          </li>
          <li>
            <strong>actual time</strong> - Real execution time in ms
          </li>
        </ul>
      </div>
    </div>
  )
}
