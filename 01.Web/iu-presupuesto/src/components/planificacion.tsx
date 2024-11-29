import React, { useState } from 'react';
import {
  Box,
  Typography,
  Button,
  Paper,
  LinearProgress,
  createTheme,
  ThemeProvider,
  TextField,
} from '@mui/material';
import {
  Edit as EditIcon,
  TrendingUp as TrendingUpIcon,
  Lightbulb as LightbulbIcon,
} from '@mui/icons-material';

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

interface PlanificacionProps {
  presupuestoMensual: number;
  gastoActual: number;
  gastosEstimados: number;
  metaAhorro: number;
  ahorroActual: number;
  sugerencia: string;
  accionRecomendada: string;
  onEditClick: () => void;
}

const Planificacion: React.FC<PlanificacionProps> = ({
  presupuestoMensual,
  gastoActual,
  gastosEstimados,
  metaAhorro,
  ahorroActual,
  sugerencia,
  accionRecomendada,
  onEditClick
}) => {
  const [fecha, setFecha] = useState(new Date().toISOString().split('T')[0]);
  const porcentajeGasto = (gastoActual / presupuestoMensual) * 100;
  const porcentajeAhorro = (ahorroActual / metaAhorro) * 100;

  const handleFechaChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    setFecha(event.target.value);
  };

  return (
    <ThemeProvider theme={theme}>
      <Box sx={{ maxWidth: 600, margin: 'auto', padding: 2 }}>
        

        <Paper elevation={3} sx={{ padding: 2, marginBottom: 2, backgroundColor: 'rgba(235,248,255,1)' }}>
          <Typography variant="h5" gutterBottom>
            Presupuesto Mensual
          </Typography>
          <Typography variant="h4" gutterBottom>
            {presupuestoMensual.toLocaleString('es-PE', { style: 'currency', currency: 'PEN' })}
          </Typography>
          <Box sx={{ width: '100%', mb: 2 }}>
            <LinearProgress 
              variant="determinate" 
              value={porcentajeGasto} 
              color="primary" 
              sx={{ height: 10, borderRadius: 5 }}
            />
          </Box>
          <Typography variant="body2" paragraph>
            Gastado: {gastoActual.toLocaleString('es-PE', { style: 'currency', currency: 'PEN' })} ({porcentajeGasto.toFixed(1)}%)
          </Typography>
          <Typography variant="body2" paragraph>
            Gastos estimados: {gastosEstimados.toLocaleString('es-PE', { style: 'currency', currency: 'PEN' })}
          </Typography>
          <Box sx={{ display: 'flex', justifyContent: 'center' }}>
            <Button
              variant="contained"
              startIcon={<EditIcon />}
              color="primary"
              onClick={onEditClick}
            >
              Editar
            </Button>
          </Box>
        </Paper>

        <Paper elevation={3} sx={{ padding: 2, marginBottom: 2, backgroundColor: 'rgba(235,248,255,1)' }}>
          <Typography variant="h5" gutterBottom>
            Meta de Ahorro
          </Typography>
          <Typography variant="h4" gutterBottom>
            {metaAhorro.toLocaleString('es-PE', { style: 'currency', currency: 'PEN' })}
          </Typography>
          <Box sx={{ width: '100%', mb: 2 }}>
            <LinearProgress 
              variant="determinate" 
              value={porcentajeAhorro} 
              color="primary" 
              sx={{ height: 10, borderRadius: 5 }}
            />
          </Box>
          <Typography variant="body2" paragraph>
            Ahorrado: {ahorroActual.toLocaleString('es-PE', { style: 'currency', currency: 'PEN' })} ({porcentajeAhorro.toFixed(1)}%)
          </Typography>
          <Box sx={{ display: 'flex', justifyContent: 'center' }}>
            <Button
              variant="contained"
              startIcon={<TrendingUpIcon />}
              color="primary"
            >
              Ajustar Meta
            </Button>
          </Box>
        </Paper>

        <Paper elevation={3} sx={{ padding: 2, backgroundColor: 'rgba(235,248,255,1)' }}>
          <Typography variant="h5" gutterBottom>
            Sugerencias
          </Typography>
          <Typography variant="body1" paragraph>
            {sugerencia}
          </Typography>
          <Box sx={{ mb: 2 }}>
            <Typography variant="subtitle1" gutterBottom>
              Acción recomendada
            </Typography>
            <Typography variant="body2" paragraph>
              {accionRecomendada}
            </Typography>
          </Box>
          <Box sx={{ display: 'flex', justifyContent: 'center' }}>
            <Button
              variant="contained"
              startIcon={<LightbulbIcon />}
              color="primary"
            >
              Ver más sugerencias
            </Button>
          </Box>
        </Paper>
      </Box>
    </ThemeProvider>
  );
};

export default Planificacion;