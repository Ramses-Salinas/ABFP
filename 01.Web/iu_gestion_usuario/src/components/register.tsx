import React, {useState} from 'react';
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
import {Visibility, VisibilityOff} from '@mui/icons-material';
import {generateClient} from 'aws-amplify/api';
import {GraphQLResult} from '@aws-amplify/api-graphql';

interface RegisterFormProps {
    onSubmit: (name: string, email: string, password: string) => void;
    onLogin: () => void;
}

interface CreateUserResponse {
    crearUsuario: {
        App: boolean;
        Pasword: string;
        Correo: boolean;
        Nombre: string;
        Resumen: boolean;
    }
}

const CREATE_USER_MUTATION = `
  mutation CrearUsuario($gmail: String!, $nombre: String!, $password: String!) {
    crearUsuario(Gmail: $gmail, Nombre: $nombre, Pasword: $password) {
      App
      Pasword
      Correo
      Nombre
      Resumen
    }
  }
`;

const client = generateClient();

export default function RegisterForm({onSubmit, onLogin}: RegisterFormProps) {
    const [name, setName] = useState('');
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [confirmPassword, setConfirmPassword] = useState('');
    const [showPassword, setShowPassword] = useState(false);
    const [showConfirmPassword, setShowConfirmPassword] = useState(false);
    const [error, setError] = useState<string | null>(null);
    const [isLoading, setIsLoading] = useState(false);

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        setError(null);
        setIsLoading(true);

        try {
            if (!name || !email || !password || !confirmPassword) {
                setError('Por favor, completa todos los campos');
                setIsLoading(false);
                return;
            }

            if (!/\S+@\S+\.\S+/.test(email)) {
                setError('Por favor, ingresa un correo electrónico válido');
                setIsLoading(false);
                return;
            }

            if (password !== confirmPassword) {
                setError('Las contraseñas no coinciden');
                setIsLoading(false);
                return;
            }

            if (password.length < 8) {
                setError('La contraseña debe tener al menos 8 caracteres');
                setIsLoading(false);
                return;
            }

            const response = await client.graphql({
                query: CREATE_USER_MUTATION,
                variables: {
                    gmail: email,
                    nombre: name,
                    password: password
                }
            }) as GraphQLResult<CreateUserResponse>;

            console.log('Respuesta del servidor:', response);

            if (response.data?.crearUsuario?.App) {
                onSubmit(name, email, password);
            } else {
                setError('Error al crear el usuario. Por favor, intenta de nuevo.');
            }

        } catch (error: any) {
            console.error('Error en el registro:', error);
            if (error.errors?.[0]?.errorType === 'ConflictError') {
                setError('Este correo electrónico ya está registrado');
            } else {
                setError('Hubo un error al crear tu cuenta. Por favor, intenta de nuevo.');
            }
        } finally {
            setIsLoading(false);
        }
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

                <Typography component="h1" variant="h5" sx={{mb: 1, color: 'white'}}>
                    Crea una Cuenta
                </Typography>

                <Typography variant="body1" sx={{mb: 4, width: '100%', textAlign: 'center', color: 'white'}}>
                    Únete a Financial Wellness
                </Typography>

                <Box component="form" onSubmit={handleSubmit} noValidate sx={{mt: 1, width: '100%'}}>
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
                                <InputAdornment position="end" sx={{mr: '15px'}}>
                                    <IconButton
                                        aria-label="toggle password visibility"
                                        onClick={handleTogglePasswordVisibility}
                                        edge="end"
                                        sx={iconButtonStyles}
                                    >
                                        {showPassword ? <VisibilityOff/> : <Visibility/>}
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
                                <InputAdornment position="end" sx={{mr: '15px'}}>
                                    <IconButton
                                        aria-label="toggle confirm password visibility"
                                        onClick={handleToggleConfirmPasswordVisibility}
                                        edge="end"
                                        sx={iconButtonStyles}
                                    >
                                        {showConfirmPassword ? <VisibilityOff/> : <Visibility/>}
                                    </IconButton>
                                </InputAdornment>
                            ),
                        }}
                        sx={inputStyles}
                    />

                    {error && (
                        <Alert severity="error" sx={{mt: 2}}>
                            {error}
                        </Alert>
                    )}

                    <Button
                        type="submit"
                        fullWidth
                        variant="contained"
                        sx={{
                            mt: 3,
                            mb: 2,
                            backgroundColor: 'rgba(88,101,242,1)',
                            '&:hover': {
                                backgroundColor: 'rgba(88,101,242,1)',
                            },
                        }}
                        disabled={isLoading}
                    >
                        {isLoading ? 'Registrando...' : 'Registrarse'}
                    </Button>

                    <Button
                        fullWidth
                        variant="text"
                        sx={{mt: 1, color: 'white', textTransform: 'none'}}
                        onClick={onLogin}
                    >
                        ¿Ya tienes cuenta? Inicia sesión
                    </Button>
                </Box>
            </Box>
        </Container>
    );
}