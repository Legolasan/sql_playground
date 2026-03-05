import { usePlaygroundStore } from '../../store/store'
import { Bot, CheckCircle, AlertTriangle, Sparkles } from 'lucide-react'

export default function AIFeedback() {
  const { feedback } = usePlaygroundStore()

  if (!feedback) {
    return null
  }

  return (
    <div className="p-4">
      <div className="flex items-center gap-2 mb-4">
        <Bot className="text-purple-500" size={20} />
        <h3 className="font-medium">AI Feedback</h3>
        {feedback.is_correct !== null && (
          <span
            className={`ml-auto flex items-center gap-1 px-2 py-1 rounded-full text-xs ${
              feedback.is_correct
                ? 'bg-green-900/50 text-green-400'
                : 'bg-yellow-900/50 text-yellow-400'
            }`}
          >
            {feedback.is_correct ? (
              <>
                <CheckCircle size={12} /> Correct
              </>
            ) : (
              <>
                <AlertTriangle size={12} /> Needs Work
              </>
            )}
          </span>
        )}
      </div>

      {/* Main feedback */}
      <div className="bg-gray-900 rounded-lg p-4 mb-4">
        <p className="text-gray-300">{feedback.feedback}</p>
      </div>

      {/* Suggestions */}
      {feedback.suggestions && feedback.suggestions.length > 0 && (
        <div className="mb-4">
          <h4 className="text-sm font-medium text-gray-400 mb-2 flex items-center gap-2">
            <Sparkles size={14} className="text-yellow-500" />
            Suggestions
          </h4>
          <ul className="space-y-2">
            {feedback.suggestions.map((suggestion, i) => (
              <li
                key={i}
                className="flex items-start gap-2 text-sm text-gray-300 bg-gray-800 rounded p-3"
              >
                <span className="text-yellow-500">•</span>
                {suggestion}
              </li>
            ))}
          </ul>
        </div>
      )}

      {/* Optimizations */}
      {feedback.optimizations && feedback.optimizations.length > 0 && (
        <div>
          <h4 className="text-sm font-medium text-gray-400 mb-2 flex items-center gap-2">
            <Sparkles size={14} className="text-green-500" />
            Performance Tips
          </h4>
          <ul className="space-y-2">
            {feedback.optimizations.map((tip, i) => (
              <li
                key={i}
                className="flex items-start gap-2 text-sm text-gray-300 bg-gray-800 rounded p-3"
              >
                <span className="text-green-500">•</span>
                {tip}
              </li>
            ))}
          </ul>
        </div>
      )}
    </div>
  )
}
