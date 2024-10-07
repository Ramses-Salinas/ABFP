import React, { useState, useRef } from 'react';
import {
  Box,
  Typography,
  Avatar,
  IconButton,
  TextField,
  InputAdornment,
  Switch,
  Button,
  Paper,
  Grid,
  Container,
} from '@mui/material';
import {
  CameraAlt,
  Edit,
  Visibility,
  VisibilityOff,
  Notifications,
  DataUsage,
  DeleteForever,
  Save,
  Logout,
} from '@mui/icons-material';

interface ProfileProps {
  onManejoDatos: () => void;
  onLogout: () => void;
  onDeleteAccount: () => void;
  userData: {
    username: string;
    email: string;
    avatarUrl?: string;
  };
}

export default function Profile({ onManejoDatos, onLogout, onDeleteAccount, userData }: ProfileProps) {
  const [showCurrentPassword, setShowCurrentPassword] = useState(false);
  const [showNewPassword, setShowNewPassword] = useState(false);
  const [notifications, setNotifications] = useState({
    'Notificaciones de Correo': true,
    'Alertas': false,
    'Resumen Semanal': true,
  });
  const [avatar, setAvatar] = useState<string | undefined>(userData.avatarUrl);
  const fileInputRef = useRef<HTMLInputElement>(null);
  const [editingUsername, setEditingUsername] = useState(false);
  const [editingEmail, setEditingEmail] = useState(false);
  const [username, setUsername] = useState(userData.username);
  const [email, setEmail] = useState(userData.email);
  const [currentPassword, setCurrentPassword] = useState('');
  const [newPassword, setNewPassword] = useState('');

  const handleToggleCurrentPassword = () => {
    setShowCurrentPassword(!showCurrentPassword);
  };

  const handleToggleNewPassword = () => {
    setShowNewPassword(!showNewPassword);
  };

  const handleNotificationChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    setNotifications({
      ...notifications,
      [event.target.name]: event.target.checked,
    });
  };

  const handleAvatarUpload = (event: React.ChangeEvent<HTMLInputElement>) => {
    const file = event.target.files?.[0];
    if (file) {
      const reader = new FileReader();
      reader.onload = (e) => {
        setAvatar(e.target?.result as string);
      };
      reader.readAsDataURL(file);
    }
  };

  const handleSaveChanges = () => {
    console.log('Guardando cambios:', {
      username,
      email,
      currentPassword,
      newPassword,
      notifications,
      avatar
    });
    setEditingUsername(false);
    setEditingEmail(false);
  };

  const inputStyles = {
    '& .MuiInputBase-root': {
      borderRadius: '8px',
      backgroundColor: 'rgba(36,41,47,1)',
      color: 'rgba(139,148,158,1)',
    },
    '& .MuiOutlinedInput-notchedOutline': {
      borderColor: 'rgba(88,101,242,1)',
    },
    '&:hover .MuiOutlinedInput-notchedOutline': {
      borderColor: 'rgba(88,101,242,1)',
    },
    '&.Mui-focused .MuiOutlinedInput-notchedOutline': {
      borderColor: 'rgba(88,101,242,1)',
    },
    '& .MuiInputLabel-root': {
      color: 'rgba(139,148,158,1)',
    },
    '& .MuiInputAdornment-root': {
      position: 'absolute',
      right: '8px',
    },
    '& .MuiIconButton-root': {
      padding: '8px',
    },
    '& .MuiSvgIcon-root': {
      color: 'rgba(139,148,158,1)',
    },
  };

  return (
    <Container maxWidth="md">
      <Box sx={{ position: 'relative', padding: 2 }}>
        <Button
          onClick={onLogout}
          startIcon={<Logout />}
          sx={{ 
            position: 'absolute', 
            top: 16, 
            right: -200,
            color: 'rgba(218,52,52,1)',
            textTransform: 'none',
            '&:hover': {
              backgroundColor: 'rgba(218,52,52,0.1)',
            },
          }}
          aria-label="Cerrar sesión"
        >
          Cerrar sesión
        </Button>
        
        <Box sx={{ maxWidth: 900, margin: 'auto' }}>
          {/* Información Personal */}
          <Paper elevation={3} sx={{ padding: 2, marginBottom: 2, backgroundColor: 'rgba(235,248,255,1)' }}>
            <Typography variant="h5" gutterBottom>
              Información Personal
            </Typography>
            <Box sx={{ display: 'flex', flexDirection: 'column', alignItems: 'center', mb: 2 }}>
              <Avatar src={avatar} sx={{ width: 100, height: 100, mb: 1 }}>
                {!avatar && userData.username.charAt(0).toUpperCase()}
              </Avatar>
              <input
                type="file"
                hidden
                ref={fileInputRef}
                onChange={handleAvatarUpload}
                accept="image/*"
              />
              <IconButton 
                size="small" 
                sx={{ mt: -4, mr: -10 }}
                onClick={() => fileInputRef.current?.click()}
              >
                <CameraAlt />
              </IconButton>
            </Box>
            <Box sx={{ display: 'flex', alignItems: 'center', mb: 2 }}>
              {editingUsername ? (
                <TextField
                  fullWidth
                  label="Nombre de Usuario"
                  variant="outlined"
                  value={username}
                  onChange={(e) => setUsername(e.target.value)}
                  InputProps={{
                    endAdornment: (
                      <InputAdornment position="end" sx={{ mr: '15px' }}>
                        <IconButton edge="end" onClick={() => setEditingUsername(false)}>
                          <Edit />
                        </IconButton>
                      </InputAdornment>
                    ),
                  }}
                  sx={inputStyles}
                />
              ) : (
                <>
                  <Typography variant="body1" sx={{ flexGrow: 1 }}>
                    {username}
                  </Typography>
                  <IconButton onClick={() => setEditingUsername(true)}>
                    <Edit />
                  </IconButton>
                </>
              )}
            </Box>
            <Box sx={{ display: 'flex', alignItems: 'center', mb: 2 }}>
              {editingEmail ? (
                <TextField
                  fullWidth
                  label="Correo Electrónico"
                  variant="outlined"
                  value={email}
                  onChange={(e) => setEmail(e.target.value)}
                  InputProps={{
                    endAdornment: (
                      <InputAdornment position="end" sx={{ mr: '15px' }}>
                        <IconButton edge="end" onClick={() => setEditingEmail(false)}>
                          <Edit />
                        </IconButton>
                      </InputAdornment>
                    ),
                  }}
                  sx={inputStyles}
                />
              ) : (
                <>
                  <Typography variant="body1" sx={{ flexGrow: 1 }}>
                    {email}
                  </Typography>
                  <IconButton onClick={() => setEditingEmail(true)}>
                    <Edit />
                  </IconButton>
                </>
              )}
            </Box>
            <TextField
              fullWidth
              label="Contraseña Actual"
              type={showCurrentPassword ? 'text' : 'password'}
              variant="outlined"
              margin="normal"
              value={currentPassword}
              onChange={(e) => setCurrentPassword(e.target.value)}
              InputProps={{
                endAdornment: (
                  <InputAdornment position="end" sx={{ mr: '15px' }}>
                    <IconButton onClick={handleToggleCurrentPassword} edge="end">
                      {showCurrentPassword ? <VisibilityOff /> : <Visibility />}
                    </IconButton>
                  </InputAdornment>
                ),
              }}
              sx={inputStyles}
            />
            <TextField
              fullWidth
              label="Nueva Contraseña"
              type={showNewPassword ? 'text' : 'password'}
              variant="outlined"
              margin="normal"
              value={newPassword}
              onChange={(e) => setNewPassword(e.target.value)}
              InputProps={{
                endAdornment: (
                  <InputAdornment position="end" sx={{ mr: '15px' }}>
                    <IconButton onClick={handleToggleNewPassword} edge="end">
                      {showNewPassword ? <VisibilityOff /> : <Visibility />}
                    </IconButton>
                  </InputAdornment>
                ),
              }}
              sx={inputStyles}
            />
          </Paper>

          {/* Notificaciones */}
          <Paper elevation={3} sx={{ padding: 2, marginBottom: 2, backgroundColor: 'rgba(235,248,255,1)' }}>
            <Typography variant="h5" gutterBottom>
              Notificaciones
            </Typography>
            <Box>
              {Object.entries(notifications).map(([key, value]) => (
                <Box key={key} sx={{ display: 'flex', alignItems: 'center', mb: 1 }}>
                  <Notifications sx={{ mr: 1 }} />
                  <Typography sx={{ flexGrow: 1 }}>
                    {key.charAt(0).toUpperCase() + key.slice(1)}
                  </Typography>
                  <Switch
                    checked={value}
                    onChange={handleNotificationChange}
                    name={key}
                    sx={{
                      '& .MuiSwitch-switchBase.Mui-checked': {
                        color: 'rgba(88,101,242,1)',
                      },
                      '& .MuiSwitch-switchBase.Mui-checked + .MuiSwitch-track': {
                        backgroundColor: 'rgba(88,101,242,1)',
                      },
                    }}
                  />
                </Box>
              ))}
            </Box>
          </Paper>

          {/* Gestión de Datos */}
          <Paper elevation={3} sx={{ padding: 2, marginBottom: 2, backgroundColor: 'rgba(235,248,255,1)' }}>
            <Typography variant="h5" gutterBottom>
              Gestión de Datos
            </Typography>
            <Grid container spacing={2}>
              <Grid item xs={6}>
                <Button
                  variant="outlined"
                  startIcon={<DataUsage />}
                  fullWidth
                  onClick={onManejoDatos}
                  sx={{
                    backgroundColor: '#ffffff',
                    color: '#000000',
                    borderColor: '#000000',
                    '&:hover': {
                      backgroundColor: '#f0f0f0',
                    },
                  }}
                >
                  Manejo de Datos
                </Button>
              </Grid>
              <Grid item xs={6}>
                <Button
                  variant="contained"
                  color="error"
                  startIcon={<DeleteForever />}
                  fullWidth
                  onClick={onDeleteAccount}
                  sx={{
                    backgroundColor: 'red',
                    color: '#000000',
                    '&:hover': {
                      backgroundColor: '#d32f2f',
                    },
                  }}
                >
                  Borrar Cuenta
                </Button>
              </Grid>
            </Grid>
          </Paper>

          <Box sx={{ display: 'flex', justifyContent: 'center' }}>
            <Button
              variant="contained"
              color="primary"
              startIcon={<Save />}
              onClick={handleSaveChanges}
              sx={{
                backgroundColor: 'rgba(88,101,242,1)',
                color: '#ffffff',
                '&:hover': {
                  backgroundColor: 'rgba(68,81,222,1)',
                },
              }}
            >
              Guardar Cambios
            </Button>
          </Box>
        </Box>
      </Box>
    </Container>
  );
}