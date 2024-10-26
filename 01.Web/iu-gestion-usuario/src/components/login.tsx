import React, { useState } from 'react';
import { 
  Button, 
  TextField, 
  Typography, 
  Alert,
  Box,
  Link,
  Container,
  Dialog,
  DialogTitle,
  DialogContent,
  DialogContentText,
  DialogActions,
  InputAdornment,
  IconButton,
} from '@mui/material';

import DarkModeOutlinedIcon from '@mui/icons-material/DarkModeOutlined';
import { Visibility, VisibilityOff } from '@mui/icons-material';

interface LoginFormProps {
  onSubmit: (email: string, password: string) => void;
  onForgotPassword: (email: string) => void;
  onRegister: () => void;
}

export default function LoginForm({ onSubmit, onForgotPassword, onRegister }: LoginFormProps) {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [showPassword, setShowPassword] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [showPasswordSentNotification, setShowPasswordSentNotification] = useState(false);

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    setError(null);

    if (!email || !password) {
      setError('Por favor, completa todos los campos');
      return;
    }

    if (!/\S+@\S+\.\S+/.test(email)) {
      setError('Por favor, ingresa un correo electrónico válido');
      return;
    }

    onSubmit(email, password);
  };

  const handleForgotPassword = () => {
    if (!email) {
      setError('Por favor, ingresa tu correo electrónico antes de solicitar el restablecimiento de contraseña');
      return;
    }

    if (!/\S+@\S+\.\S+/.test(email)) {
      setError('Por favor, ingresa un correo electrónico válido');
      return;
    }

    onForgotPassword(email);
    setShowPasswordSentNotification(true);
  };

  const handleCloseNotification = () => {
    setShowPasswordSentNotification(false);
  };

  const handleTogglePasswordVisibility = () => {
    setShowPassword(!showPassword);
  };

  const inputStyles = {
    '& .MuiInputBase-root': {
      backgroundColor: 'rgba(36,41,47,1)',
      borderRadius: '8px',
    },
    '& .MuiInputBase-input': {
      color: 'rgba(139,148,158,1)',
      padding: '12px',
    },
    '& .MuiOutlinedInput-notchedOutline': {
      borderColor: 'rgba(139,148,158,1)',
      borderRadius: '8px',
    },
    '&:hover .MuiOutlinedInput-notchedOutline': {
      borderColor: 'rgba(139,148,158,1)',
    },
    '&.Mui-focused .MuiOutlinedInput-notchedOutline': {
      borderColor: 'rgba(88,101,242,1)',
    },
    '& .MuiInputLabel-root': {
      color: 'rgba(139,148,158,1)',
    },
    '& .MuiInputBase-input::placeholder': {
      color: 'rgba(139,148,158,1)',
      opacity: 1,
    },
  };

  const iconButtonStyles = {
    color: 'white',
    padding: '8px',
  };

  return (
    <Container component="main" maxWidth="xs">
      <Box
        sx={{
          marginTop: 0,
          display: 'flex',
          flexDirection: 'column',
          alignItems: 'center',
        }}
      >
        <DarkModeOutlinedIcon
          sx={{
            height: 100,
            width: 100,
            marginBottom: 2,
            color: 'rgba(88,101,242,1)',
          }}          
        />

        <Typography component="h1" variant="h5" sx={{ mb: 3 , color:'white'}}>
          Financial Wellness
        </Typography>
        
        <Typography variant="body1" sx={{ mb: 4, width: '100%', textAlign: 'center' , color:'white'}}>
          Inicia sesión en tu cuenta o crea una cuenta nueva
        </Typography>

        <Box component="form" onSubmit={handleSubmit} noValidate sx={{ mt: 1, width: '100%' }}>
          <TextField
            margin="normal"
            required
            fullWidth
            id="email"
            label="Correo Electrónico"
            name="email"
            autoComplete="email"
            autoFocus
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            inputProps={{
              'aria-label': 'Correo Electrónico',
            }}
            sx={inputStyles}
          />
          <TextField
            margin="normal"
            required
            fullWidth
            name="password"
            label="Contraseña"
            type={showPassword ? 'text' : 'password'}
            id="password"
            autoComplete="current-password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            InputProps={{
              endAdornment: (
                <InputAdornment position="end" sx={{ mr: '15px' }}>
                  <IconButton
                    aria-label="toggle password visibility"
                    onClick={handleTogglePasswordVisibility}
                    edge="end"
                    sx={iconButtonStyles}
                  >
                    {showPassword ? <VisibilityOff /> : <Visibility />}
                  </IconButton>
                </InputAdornment>
              ),
            }}
            sx={{
              ...inputStyles,
              '& .MuiInputBase-root': {
                ...inputStyles['& .MuiInputBase-root'],
                paddingRight: 0,
              },
              '& .MuiInputAdornment-root': {
                backgroundColor: 'transparent',
                height: '100%',
                maxHeight: 'none',
                '& .MuiIconButton-root': {
                  height: '100%',
                },
              },
            }}
          />
          {error && (
            <Alert severity="error" sx={{ mt: 2 }}>
              {error}
            </Alert>
          )}
          <Button
            type="submit"
            fullWidth
            variant="contained"
            sx={{ 
              mt: 5, 
              mb: 3, 
              backgroundColor:'rgba(88,101,242,1)',
              '&:hover': {backgroundColor: 'rgba(68, 81, 182, 1)' },
            }}
          >
            Iniciar Sesión
          </Button>
          <Button
            fullWidth
            variant="outlined"
            onClick={onRegister}
            sx={{ 
              mb: 3, 
              color: 'rgba(88,101,242,1)',
              backgroundColor:'rgba(36,41,47,1)',
              borderColor: 'rgba(36,41,47,1)',
            }}
          >
            Registrarse
          </Button>
          <Box sx={{ textAlign: 'center' }}>
            <Link
              component="button"
              variant="body2"
              onClick={handleForgotPassword}
              sx={{ cursor: 'pointer' , color: 'rgba(88,101,242,1)'}}
            >
              ¿Olvidaste tu contraseña?
            </Link>
          </Box>
        </Box>
      </Box>
      <Dialog
        open={showPasswordSentNotification}
        onClose={handleCloseNotification}
        aria-labelledby="password-reset-dialog-title"
        aria-describedby="password-reset-dialog-description"
      >
        <DialogTitle id="password-reset-dialog-title">
          Restablecimiento de Contraseña
        </DialogTitle>
        <DialogContent>
          <DialogContentText id="password-reset-dialog-description">
            Se ha enviado un correo con instrucciones para restablecer tu contraseña a la dirección: {email}
          </DialogContentText>
        </DialogContent>
        <DialogActions>
          <Button onClick={handleCloseNotification} autoFocus>
            Cerrar
          </Button>
        </DialogActions>
      </Dialog>
    </Container>
  );
}