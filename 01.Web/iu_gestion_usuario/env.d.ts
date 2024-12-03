/// <reference types="vite/client" />

interface ImportMetaEnv {
    readonly VITE_APP_APPSYNC_ENDPOINT: string
    readonly VITE_APP_AWS_REGION: string
    readonly VITE_APP_API_KEY: string
  }
  
  interface ImportMeta {
    readonly env: ImportMetaEnv
  }