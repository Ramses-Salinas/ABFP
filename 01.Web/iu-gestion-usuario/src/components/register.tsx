import React, { useState } from 'react';
import { 
  Button, 
  TextField, 
  Typography, 
  Alert,
  Box,
  Container,
  InputAdornment,
  IconButton,
} from '@mui/material';
import DarkModeOutlinedIcon from '@mui/icons-material/DarkModeOutlined';
import { Visibility, VisibilityOff } from '@mui/icons-material';

interface RegisterFormProps {
  onSubmit: (name: string, email: string, password: string) => void;
  onLogin: () => void;
}

export default function RegisterForm({ onSubmit, onLogin }: RegisterFormProps) {
  const [name, setName] = useState('');
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [showPassword, setShowPassword] = useState(false);
  const [showConfirmPassword, setShowConfirmPassword] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    setError(null);

    if (!name || !email || !password || !confirmPassword) {
      setError('Por favor, completa todos los campos');
      return;
    }

    if (!/\S+@\S+\.\S+/.test(email)) {
      setError('Por favor, ingresa un correo electrónico válido');
      return;
    }

    if (password !== confirmPassword) {
      setError('Las contraseñas no coinciden');
      return;
    }

    if (password.length < 8) {
      setError('La contraseña debe tener al menos 8 caracteres');
      return;
    }

    onSubmit(name, email, password);
  };

  const handleTogglePasswordVisibility = () => {
    setShowPassword(!showPassword);
  };

  const handleToggleConfirmPasswordVisibility = () => {
    setShowConfirmPassword(!showConfirmPassword);
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

        <Typography component="h1" variant="h5" sx={{ mb: 1, color: 'white' }}>
          Crea una Cuenta
        </Typography>
        
        <Typography variant="body1" sx={{ mb: 4, width: '100%', textAlign: 'center', color: 'white' }}>
          Únete a Financial Wellness
        </Typography>

        <Box component="form" onSubmit={handleSubmit} noValidate sx={{ mt: 1, width: '100%' }}>
          <TextField
            margin="normal"
            required
            fullWidth
            id="name"
            label="Nombre Completo"
            name="name"
            autoComplete="name"
            autoFocus
            value={name}
            onChange={(e) => setName(e.target.value)}
            inputProps={{
              'aria-label': 'Nombre Completo',
            }}
            sx={inputStyles}
          />
          <TextField
            margin="normal"
            required
            fullWidth
            id="email"
            label="Correo Electrónico"
            name="email"
            autoComplete="email"
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
            autoComplete="new-password"
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
          <TextField
            margin="normal"
            required
            fullWidth
            name="confirmPassword"
            label="Confirmar Contraseña"
            type={showConfirmPassword ? 'text' : 'password'}
            id="confirmPassword"
            autoComplete="new-password"
            value={confirmPassword}
            onChange={(e) => setConfirmPassword(e.target.value)}
            InputProps={{
              endAdornment: (
                <InputAdornment position="end" sx={{ mr: '15px' }}>
                  <IconButton
                    aria-label="toggle confirm password visibility"
                    onClick={handleToggleConfirmPasswordVisibility}
                    edge="end"
                    sx={iconButtonStyles}
                  >
                    {showConfirmPassword ? <VisibilityOff /> : <Visibility />}
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
              backgroundColor: 'rgba(88,101,242,1)',
              '&:hover': {backgroundColor: 'rgba(68, 81, 182, 1)' },
            }}
          >
            Registrarse
          </Button>
          <Button
            fullWidth
            variant="outlined"
            onClick={onLogin}
            sx={{ 
              mb: 3, 
              color: 'rgba(88,101,242,1)',
              backgroundColor: 'rgba(36,41,47,1)',
              borderColor: 'rgba(36,41,47,1)',
            }}
          >
            ¿Ya tienes una cuenta? Inicia sesión
          </Button>
        </Box>
      </Box>
    </Container>
  );
}