import { Play, FileText, Lightbulb, Save, RotateCcw } from 'lucide-react'
import { usePlaygroundStore } from '../../store/store'
import { executeQuery, explainQuery, getFeedback } from '../../api/client'

export default function EditorToolbar() {
  const {
    query,
    dataset,
    setResults,
    isExecuting,
    setIsExecuting,
    setExplainResult,
    setShowExplain,
    setFeedback,
    setShowFeedback,
    currentChallenge,
  } = usePlaygroundStore()

  const handleRun = async () => {
    setIsExecuting(true)
    setShowExplain(false)
    setShowFeedback(false)
    try {
      const result = await executeQuery(query, dataset)
      setResults(result)
    } catch (error: any) {
      setResults({
        success: false,
        columns: [],
        rows: [],
        row_count: 0,
        execution_time_ms: 0,
        error: error.response?.data?.detail || error.message,
      })
    }
    setIsExecuting(false)
  }

  const handleExplain = async () => {
    setIsExecuting(true)
    try {
      const result = await explainQuery(query, dataset)
      setExplainResult(result)
      setShowExplain(true)
      setShowFeedback(false)
    } catch (error: any) {
      console.error('Explain error:', error)
    }
    setIsExecuting(false)
  }

  const handleFeedback = async () => {
    setIsExecuting(true)
    try {
      const result = await getFeedback(query, dataset, currentChallenge?.id)
      setFeedback(result)
      setShowFeedback(true)
      setShowExplain(false)
    } catch (error: any) {
      console.error('Feedback error:', error)
    }
    setIsExecuting(false)
  }

  const handleClear = () => {
    setResults(null)
    setExplainResult(null)
    setFeedback(null)
    setShowExplain(false)
    setShowFeedback(false)
  }

  return (
    <div className="flex items-center gap-2 mb-4">
      <button
        onClick={handleRun}
        disabled={isExecuting}
        className="flex items-center gap-2 px-4 py-2 bg-green-600 hover:bg-green-700 disabled:bg-green-800 disabled:cursor-not-allowed rounded-lg font-medium transition-colors"
      >
        <Play size={16} />
        {isExecuting ? 'Running...' : 'Run Query'}
      </button>

      <button
        onClick={handleExplain}
        disabled={isExecuting}
        className="flex items-center gap-2 px-4 py-2 bg-gray-700 hover:bg-gray-600 rounded-lg transition-colors"
      >
        <FileText size={16} />
        Explain
      </button>

      <button
        onClick={handleFeedback}
        disabled={isExecuting}
        className="flex items-center gap-2 px-4 py-2 bg-purple-600 hover:bg-purple-700 rounded-lg transition-colors"
      >
        <Lightbulb size={16} />
        AI Feedback
      </button>

      <div className="ml-auto flex items-center gap-2">
        <button
          onClick={handleClear}
          className="flex items-center gap-2 px-3 py-2 text-gray-400 hover:text-white hover:bg-gray-700 rounded-lg transition-colors"
        >
          <RotateCcw size={16} />
          Clear
        </button>

        <button className="flex items-center gap-2 px-3 py-2 text-gray-400 hover:text-white hover:bg-gray-700 rounded-lg transition-colors">
          <Save size={16} />
          Save
        </button>
      </div>
    </div>
  )
}
