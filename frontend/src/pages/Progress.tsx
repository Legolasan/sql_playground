import { useState, useEffect } from 'react'
import { getStats, getSavedQueries } from '../api/client'
import { Trophy, Target, Database, Clock, Bookmark, Trash2 } from 'lucide-react'

interface Stats {
  total_challenges: number
  solved: number
  attempted: number
  total_queries_run: number
  streak_days: number
}

interface SavedQuery {
  id: number
  title: string
  query: string
  dataset: string
  is_bookmarked: boolean
  created_at: string
}

export default function Progress() {
  const [stats, setStats] = useState<Stats | null>(null)
  const [savedQueries, setSavedQueries] = useState<SavedQuery[]>([])
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    const loadData = async () => {
      setLoading(true)
      try {
        const [statsData, savedData] = await Promise.all([
          getStats(),
          getSavedQueries(),
        ])
        setStats(statsData)
        setSavedQueries(savedData)
      } catch (error) {
        console.error('Failed to load progress:', error)
      }
      setLoading(false)
    }
    loadData()
  }, [])

  if (loading) {
    return (
      <div className="flex items-center justify-center h-full">
        <div className="text-gray-500">Loading progress...</div>
      </div>
    )
  }

  const completionPercentage = stats
    ? Math.round((stats.solved / stats.total_challenges) * 100)
    : 0

  return (
    <div className="p-6 max-w-4xl mx-auto">
      <h1 className="text-2xl font-bold mb-6">Your Progress</h1>

      {/* Stats cards */}
      <div className="grid grid-cols-2 md:grid-cols-4 gap-4 mb-8">
        <div className="bg-sql-dark p-4 rounded-lg border border-gray-700">
          <div className="flex items-center gap-2 text-green-500 mb-2">
            <Trophy size={20} />
            <span className="text-sm text-gray-400">Solved</span>
          </div>
          <div className="text-2xl font-bold">{stats?.solved || 0}</div>
        </div>

        <div className="bg-sql-dark p-4 rounded-lg border border-gray-700">
          <div className="flex items-center gap-2 text-yellow-500 mb-2">
            <Target size={20} />
            <span className="text-sm text-gray-400">Attempted</span>
          </div>
          <div className="text-2xl font-bold">{stats?.attempted || 0}</div>
        </div>

        <div className="bg-sql-dark p-4 rounded-lg border border-gray-700">
          <div className="flex items-center gap-2 text-sql-accent mb-2">
            <Database size={20} />
            <span className="text-sm text-gray-400">Queries Run</span>
          </div>
          <div className="text-2xl font-bold">{stats?.total_queries_run || 0}</div>
        </div>

        <div className="bg-sql-dark p-4 rounded-lg border border-gray-700">
          <div className="flex items-center gap-2 text-purple-500 mb-2">
            <Clock size={20} />
            <span className="text-sm text-gray-400">Day Streak</span>
          </div>
          <div className="text-2xl font-bold">{stats?.streak_days || 0}</div>
        </div>
      </div>

      {/* Progress bar */}
      <div className="bg-sql-dark p-6 rounded-lg border border-gray-700 mb-8">
        <div className="flex items-center justify-between mb-2">
          <h3 className="font-medium">Overall Progress</h3>
          <span className="text-sm text-gray-400">
            {stats?.solved || 0} / {stats?.total_challenges || 0} challenges
          </span>
        </div>
        <div className="h-4 bg-gray-800 rounded-full overflow-hidden">
          <div
            className="h-full bg-gradient-to-r from-sql-accent to-green-500 transition-all duration-500"
            style={{ width: `${completionPercentage}%` }}
          />
        </div>
        <div className="mt-2 text-sm text-gray-500">
          {completionPercentage}% complete
        </div>
      </div>

      {/* Saved queries */}
      <div className="bg-sql-dark rounded-lg border border-gray-700">
        <div className="p-4 border-b border-gray-700">
          <h3 className="font-medium flex items-center gap-2">
            <Bookmark size={18} />
            Saved Queries
          </h3>
        </div>
        {savedQueries.length === 0 ? (
          <div className="p-8 text-center text-gray-500">
            No saved queries yet. Save queries from the playground!
          </div>
        ) : (
          <div className="divide-y divide-gray-700">
            {savedQueries.map((query) => (
              <div key={query.id} className="p-4 hover:bg-gray-800/50">
                <div className="flex items-start justify-between">
                  <div>
                    <h4 className="font-medium flex items-center gap-2">
                      {query.title}
                      {query.is_bookmarked && (
                        <Bookmark size={14} className="text-yellow-500 fill-yellow-500" />
                      )}
                    </h4>
                    <span className="text-xs text-gray-500">{query.dataset}</span>
                  </div>
                  <button className="text-gray-500 hover:text-red-500">
                    <Trash2 size={16} />
                  </button>
                </div>
                <pre className="mt-2 text-sm text-gray-400 font-mono bg-gray-900 p-2 rounded overflow-x-auto">
                  {query.query}
                </pre>
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  )
}
