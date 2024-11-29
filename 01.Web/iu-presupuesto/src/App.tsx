import React, { useState } from 'react'
import ReactDOM from 'react-dom/client'
import { ThemeProvider, createTheme, CssBaseline, Container, Box } from '@mui/material'
import Planificacion from './components/planificacion'
import EditarPresupuesto from './components/editarpresupuesto'

import './index.css'

const theme = createTheme({
  palette: {
    primary: {
      main: 'rgba(88,101,242,1)',
    },
  },
  typography: {
    h5: {
      fontWeight: 700,
    },
    subtitle1: {
      fontWeight: 700,
    },
  },
});

type View = 'planificacion' | 'editarPresupuesto';

interface PresupuestoData {
  presupuestoMensual: number;
  gastoActual: number;
  gastosEstimados: number;
  metaAhorro: number;
  ahorroActual: number;
  sugerencia: string;
  accionRecomendada: string;
  presupuestoTotal: number;
  categorias: Array<{ id: number; nombre: string; cantidad: number }>;
}

const App: React.FC = () => {
  const [currentView, setCurrentView] = useState<View>('planificacion');
  const [presupuestoData, setPresupuestoData] = useState<PresupuestoData>({
    presupuestoMensual: 3000,
    gastoActual: 1500,
    gastosEstimados: 2800,
    metaAhorro: 1000,
    ahorroActual: 300,
    sugerencia: "Estás en buen camino para alcanzar tu meta de ahorro.",
    accionRecomendada: "Considera reducir tus gastos en entretenimiento para aumentar tu ahorro.",
    presupuestoTotal: 36000,
    categorias: [
      { id: 1, nombre: 'Alimentación', cantidad: 1000 },
      { id: 2, nombre: 'Transporte', cantidad: 500 },
      { id: 3, nombre: 'Entretenimiento', cantidad: 300 },
    ],
  });

  const handleEditClick = () => {
    setCurrentView('editarPresupuesto');
  };

  const handleSaveChanges = (newData: PresupuestoData) => {
    setPresupuestoData(newData);
    setCurrentView('planificacion');
  };

  const renderView = () => {
    switch (currentView) {
      case 'planificacion':
        return (
          <Planificacion
            presupuestoMensual={presupuestoData.presupuestoMensual}
            gastoActual={presupuestoData.gastoActual}
            gastosEstimados={presupuestoData.gastosEstimados}
            metaAhorro={presupuestoData.metaAhorro}
            ahorroActual={presupuestoData.ahorroActual}
            sugerencia={presupuestoData.sugerencia}
            accionRecomendada={presupuestoData.accionRecomendada}
            onEditClick={handleEditClick}
          />
        );
      case 'editarPresupuesto':
        return (
          <EditarPresupuesto
            presupuestoData={presupuestoData}
            onSaveChanges={handleSaveChanges}
          />
        );
    }
  };

  return (
    <ThemeProvider theme={theme}>
      <CssBaseline />
      <Container component="main" maxWidth="md">
        <Box sx={{ marginTop: 8 }}>
          <h1>IU Presupuesto</h1>
          {renderView()}
        </Box>
      </Container>
    </ThemeProvider>
  );
}

const rootElement = document.getElementById('app')
if (!rootElement) throw new Error('Failed to find the root element')

const root = ReactDOM.createRoot(rootElement)

root.render(<App />)

export default App