import {StrictMode} from 'react'
import {createRoot} from 'react-dom/client'
import './index.css'
import IUGestionUsuario from './IUGestionUsuario.tsx'

createRoot(document.getElementById('root')!).render(
    <StrictMode>
        <IUGestionUsuario/>
    </StrictMode>,
)
