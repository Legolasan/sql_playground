import Editor from '@monaco-editor/react'
import { usePlaygroundStore } from '../../store/store'

interface SQLEditorProps {
  height?: string
}

export default function SQLEditor({ height = '300px' }: SQLEditorProps) {
  const { query, setQuery } = usePlaygroundStore()

  return (
    <div className="border border-gray-700 rounded-lg overflow-hidden">
      <Editor
        height={height}
        defaultLanguage="sql"
        theme="vs-dark"
        value={query}
        onChange={(value) => setQuery(value || '')}
        options={{
          minimap: { enabled: false },
          fontSize: 14,
          lineNumbers: 'on',
          scrollBeyondLastLine: false,
          wordWrap: 'on',
          tabSize: 2,
          automaticLayout: true,
          padding: { top: 16, bottom: 16 },
          suggestOnTriggerCharacters: true,
          quickSuggestions: true,
        }}
      />
    </div>
  )
}
