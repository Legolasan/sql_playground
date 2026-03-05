import { useEffect } from 'react'
import { useParams } from 'react-router-dom'
import SQLEditor from '../components/Editor/SQLEditor'
import EditorToolbar from '../components/Editor/EditorToolbar'
import ResultsTable from '../components/Results/ResultsTable'
import ExplainView from '../components/Results/ExplainView'
import AIFeedback from '../components/Feedback/AIFeedback'
import { usePlaygroundStore } from '../store/store'
import { getChallenge } from '../api/client'
import { Target, Star } from 'lucide-react'

export default function Playground() {
  const { id } = useParams()
  const {
    currentChallenge,
    setCurrentChallenge,
    setQuery,
    setDataset,
    showExplain,
    showFeedback,
  } = usePlaygroundStore()

  useEffect(() => {
    if (id) {
      const loadChallenge = async () => {
        try {
          const challenge = await getChallenge(parseInt(id))
          setCurrentChallenge(challenge)
          setDataset(challenge.dataset)
          if (challenge.starter_code) {
            setQuery(challenge.starter_code)
          } else {
            setQuery(`-- ${challenge.title}\n-- ${challenge.description}\n\n`)
          }
        } catch (error) {
          console.error('Failed to load challenge:', error)
        }
      }
      loadChallenge()
    } else {
      setCurrentChallenge(null)
    }
  }, [id])

  return (
    <div className="h-full flex flex-col p-4">
      {/* Challenge header */}
      {currentChallenge && (
        <div className="mb-4 p-4 bg-sql-dark rounded-lg border border-gray-700">
          <div className="flex items-start justify-between">
            <div>
              <div className="flex items-center gap-2 text-sm text-gray-500 mb-1">
                <Target size={14} />
                <span>{currentChallenge.category_name}</span>
              </div>
              <h2 className="text-xl font-semibold mb-2">
                {currentChallenge.title}
              </h2>
              <p className="text-gray-400">{currentChallenge.description}</p>
            </div>
            <div className="flex items-center gap-1">
              {Array.from({ length: 5 }).map((_, i) => (
                <Star
                  key={i}
                  size={16}
                  className={
                    i < currentChallenge.difficulty
                      ? 'text-yellow-500 fill-yellow-500'
                      : 'text-gray-600'
                  }
                />
              ))}
            </div>
          </div>
          {currentChallenge.hint && (
            <details className="mt-3">
              <summary className="text-sm text-sql-accent cursor-pointer hover:underline">
                Show hint
              </summary>
              <p className="mt-2 text-sm text-gray-400 pl-4 border-l-2 border-sql-accent">
                {currentChallenge.hint}
              </p>
            </details>
          )}
        </div>
      )}

      {/* Editor */}
      <div className="mb-4">
        <EditorToolbar />
        <SQLEditor height="250px" />
      </div>

      {/* Results area */}
      <div className="flex-1 bg-sql-dark rounded-lg border border-gray-700 overflow-hidden">
        <div className="h-full">
          {showExplain ? (
            <ExplainView />
          ) : showFeedback ? (
            <AIFeedback />
          ) : (
            <ResultsTable />
          )}
        </div>
      </div>
    </div>
  )
}
