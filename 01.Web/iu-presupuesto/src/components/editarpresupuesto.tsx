import React, { useState } from 'react';
import {
  Box,
  Typography,
  Button,
  Paper,
  TextField,
  IconButton,
  Stack,
} from '@mui/material';
import { 
  Edit as EditIcon,
  Delete as DeleteIcon,
  Add as AddIcon,
} from '@mui/icons-material';

interface Categoria {
  id: number;
  nombre: string;
  cantidad: number;
}

interface PresupuestoData {
  presupuestoMensual: number;
  presupuestoTotal: number;
  categorias: Categoria[];
  gastoActual: number;
  gastosEstimados: number;
  metaAhorro: number;
  ahorroActual: number;
  sugerencia: string;
  accionRecomendada: string;
}

interface EditarPresupuestoProps {
  presupuestoData: PresupuestoData;
  onSaveChanges: (newData: PresupuestoData) => void;
}

const EditarPresupuesto: React.FC<EditarPresupuestoProps> = ({ presupuestoData, onSaveChanges }) => {
  const [localPresupuestoData, setLocalPresupuestoData] = useState<PresupuestoData>(presupuestoData);

  const handleEditPresupuestoMensual = () => {
    const nuevoPresupuesto = prompt('Ingrese el nuevo presupuesto mensual:', localPresupuestoData.presupuestoMensual.toString());
    if (nuevoPresupuesto !== null) {
      setLocalPresupuestoData({
        ...localPresupuestoData,
        presupuestoMensual: Number(nuevoPresupuesto)
      });
    }
  };

  const handleEditPresupuestoTotal = () => {
    const nuevoPresupuesto = prompt('Ingrese el nuevo presupuesto total:', localPresupuestoData.presupuestoTotal.toString());
    if (nuevoPresupuesto !== null) {
      setLocalPresupuestoData({
        ...localPresupuestoData,
        presupuestoTotal: Number(nuevoPresupuesto)
      });
    }
  };

  const handleEditCategoria = (id: number, campo: 'nombre' | 'cantidad', valor: string | number) => {
    setLocalPresupuestoData({
      ...localPresupuestoData,
      categorias: localPresupuestoData.categorias.map(cat => 
        cat.id === id ? { ...cat, [campo]: valor } : cat
      )
    });
  };

  const handleDeleteCategoria = (id: number) => {
    setLocalPresupuestoData({
      ...localPresupuestoData,
      categorias: localPresupuestoData.categorias.filter(cat => cat.id !== id)
    });
  };

  const handleAddCategoria = () => {
    const newId = Math.max(...localPresupuestoData.categorias.map(c => c.id), 0) + 1;
    setLocalPresupuestoData({
      ...localPresupuestoData,
      categorias: [...localPresupuestoData.categorias, { id: newId, nombre: 'Nueva Categoría', cantidad: 0 }]
    });
  };

  const handleGuardarCambios = () => {
    onSaveChanges(localPresupuestoData);
  };

  return (
    <Box sx={{ maxWidth: 600, margin: 'auto', padding: 2 }}>
      <Paper elevation={3} sx={{ padding: 2, marginBottom: 2, backgroundColor: 'background.paper' }}>
        <Typography variant="h5" gutterBottom>
          Presupuesto Mensual
        </Typography>
        <Box display="flex" alignItems="center">
          <Typography variant="h4">
            {localPresupuestoData.presupuestoMensual.toLocaleString('es-PE', { style: 'currency', currency: 'PEN' })}
          </Typography>
          <IconButton onClick={handleEditPresupuestoMensual} color="primary" sx={{ ml: 1 }}>
            <EditIcon />
          </IconButton>
        </Box>
      </Paper>

      <Paper elevation={3} sx={{ padding: 2, marginBottom: 2, backgroundColor: 'background.paper' }}>
        <Typography variant="h5" gutterBottom>
          Planificación Financiera
        </Typography>
        <Box display="flex" alignItems="center">
          <Typography variant="h6">
            Presupuesto Total: {localPresupuestoData.presupuestoTotal.toLocaleString('es-PE', { style: 'currency', currency: 'PEN' })}
          </Typography>
          <IconButton onClick={handleEditPresupuestoTotal} color="primary" sx={{ ml: 1 }}>
            <EditIcon />
          </IconButton>
        </Box>
      </Paper>

      <Paper elevation={3} sx={{ padding: 2, marginBottom: 2, backgroundColor: 'background.paper' }}>
        <Typography variant="h5" gutterBottom>
          Ajustar Categorías
        </Typography>
        <Stack spacing={2}>
          {localPresupuestoData.categorias.map((categoria) => (
            <Box key={categoria.id} sx={{ display: 'flex', alignItems: 'center' }}>
              <TextField
                value={categoria.nombre}
                onChange={(e) => handleEditCategoria(categoria.id, 'nombre', e.target.value)}
                sx={{ flexGrow: 1, mr: 1 }}
              />
              <TextField
                type="number"
                value={categoria.cantidad}
                onChange={(e) => handleEditCategoria(categoria.id, 'cantidad', Number(e.target.value))}
                sx={{ width: '100px', mr: 1 }}
              />
              <IconButton onClick={() => handleDeleteCategoria(categoria.id)} color="error">
                <DeleteIcon />
              </IconButton>
            </Box>
          ))}
        </Stack>
        <Button
          startIcon={<AddIcon />}
          onClick={handleAddCategoria}
          variant="outlined"
          color="primary"
          fullWidth
          sx={{ mt: 2 }}
        >
          Agregar Categoría
        </Button>
      </Paper>

      <Button
        variant="contained"
        color="primary"
        fullWidth
        onClick={handleGuardarCambios}
        sx={{ mt: 2 }}
      >
        Guardar Cambios
      </Button>
    </Box>
  );
};

export default EditarPresupuesto;