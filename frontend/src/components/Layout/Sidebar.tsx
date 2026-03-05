import { useState, useEffect } from 'react'
import { ChevronDown, ChevronRight, Table2, Columns } from 'lucide-react'
import { usePlaygroundStore } from '../../store/store'
import { getSchema } from '../../api/client'

interface TableSchema {
  table_name: string
  columns: {
    name: string
    type: string
    nullable: boolean
    primary_key: boolean
  }[]
}

export default function Sidebar() {
  const { dataset, setDataset } = usePlaygroundStore()
  const [schema, setSchema] = useState<TableSchema[]>([])
  const [expandedTables, setExpandedTables] = useState<Set<string>>(new Set())
  const [loading, setLoading] = useState(false)

  useEffect(() => {
    const loadSchema = async () => {
      setLoading(true)
      try {
        const data = await getSchema(dataset)
        setSchema(data.tables)
      } catch (error) {
        console.error('Failed to load schema:', error)
      }
      setLoading(false)
    }
    loadSchema()
  }, [dataset])

  const toggleTable = (tableName: string) => {
    const newExpanded = new Set(expandedTables)
    if (newExpanded.has(tableName)) {
      newExpanded.delete(tableName)
    } else {
      newExpanded.add(tableName)
    }
    setExpandedTables(newExpanded)
  }

  const datasets = [
    { value: 'ecommerce', label: 'E-commerce', emoji: '🛒' },
    { value: 'hr', label: 'HR', emoji: '👥' },
    { value: 'finance', label: 'Finance', emoji: '💰' },
  ]

  return (
    <aside className="w-64 bg-sql-dark border-r border-gray-800 flex flex-col">
      {/* Dataset selector */}
      <div className="p-4 border-b border-gray-800">
        <label className="text-xs text-gray-500 uppercase tracking-wide mb-2 block">
          Dataset
        </label>
        <select
          value={dataset}
          onChange={(e) => setDataset(e.target.value as any)}
          className="w-full bg-gray-800 border border-gray-700 rounded-lg px-3 py-2 text-sm focus:outline-none focus:border-sql-accent"
        >
          {datasets.map((d) => (
            <option key={d.value} value={d.value}>
              {d.emoji} {d.label}
            </option>
          ))}
        </select>
      </div>

      {/* Schema explorer */}
      <div className="flex-1 overflow-auto p-4">
        <h3 className="text-xs text-gray-500 uppercase tracking-wide mb-3">
          Tables
        </h3>

        {loading ? (
          <div className="text-gray-500 text-sm">Loading schema...</div>
        ) : (
          <div className="space-y-1">
            {schema.map((table) => (
              <div key={table.table_name}>
                <button
                  onClick={() => toggleTable(table.table_name)}
                  className="w-full flex items-center gap-2 px-2 py-1.5 hover:bg-gray-800 rounded text-left text-sm"
                >
                  {expandedTables.has(table.table_name) ? (
                    <ChevronDown size={14} className="text-gray-500" />
                  ) : (
                    <ChevronRight size={14} className="text-gray-500" />
                  )}
                  <Table2 size={14} className="text-sql-green" />
                  <span>{table.table_name}</span>
                </button>

                {expandedTables.has(table.table_name) && (
                  <div className="ml-6 mt-1 space-y-0.5">
                    {table.columns.map((col) => (
                      <div
                        key={col.name}
                        className="flex items-center gap-2 px-2 py-1 text-xs text-gray-400"
                      >
                        <Columns size={12} className="text-gray-600" />
                        <span className={col.primary_key ? 'text-yellow-500' : ''}>
                          {col.name}
                        </span>
                        <span className="text-gray-600 ml-auto">
                          {col.type.toLowerCase()}
                        </span>
                      </div>
                    ))}
                  </div>
                )}
              </div>
            ))}
          </div>
        )}
      </div>
    </aside>
  )
}
