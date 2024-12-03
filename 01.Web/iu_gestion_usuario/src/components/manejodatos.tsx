import React, {useState} from 'react';
import {
    Box,
    Typography,
    Button,
    Paper,
    RadioGroup,
    FormControlLabel,
    Radio,
    TextField,
    Grid,
    createTheme,
    ThemeProvider,
} from '@mui/material';
import {
    CloudUpload as CloudUploadIcon,
    GetApp as GetAppIcon,
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

const ManejoDatos: React.FC = () => {
    const [exportFormat, setExportFormat] = useState('CSV');
    const [startDate, setStartDate] = useState('');
    const [endDate, setEndDate] = useState('');

    const handleFormatChange = (event: React.ChangeEvent<HTMLInputElement>) => {
        setExportFormat(event.target.value);
    };

    return (
        <ThemeProvider theme={theme}>
            <Box sx={{maxWidth: 600, margin: 'auto', padding: 2}}>
                <Paper elevation={3} sx={{padding: 2, marginBottom: 2, backgroundColor: 'rgba(235,248,255,1)'}}>
                    <Typography variant="h5" gutterBottom>
                        Importar Datos
                    </Typography>
                    <Typography variant="body1" paragraph>
                        Importe sus datos financieros de tipo CSV.
                    </Typography>
                    <Button
                        variant="contained"
                        startIcon={<CloudUploadIcon/>}
                        component="label"
                        color="primary"
                    >
                        Importar Datos
                        <input type="file" hidden accept=".csv"/>
                    </Button>
                </Paper>

                <Paper elevation={3} sx={{padding: 2, backgroundColor: 'rgba(235,248,255,1)'}}>
                    <Typography variant="h5" gutterBottom>
                        Exportar Datos
                    </Typography>

                    <Box sx={{mb: 2}}>
                        <Typography variant="subtitle1" gutterBottom>
                            Formato de exportación
                        </Typography>
                        <RadioGroup
                            row
                            value={exportFormat}
                            onChange={handleFormatChange}
                        >
                            <FormControlLabel value="CSV" control={<Radio color="primary"/>} label="CSV"/>
                            <FormControlLabel value="PDF" control={<Radio color="primary"/>} label="PDF"/>
                        </RadioGroup>
                    </Box>

                    <Box sx={{mb: 2}}>
                        <Typography variant="subtitle1" gutterBottom>
                            Rango de fecha
                        </Typography>
                        <Grid container spacing={2}>
                            <Grid item xs={6}>
                                <TextField
                                    label="Fecha inicial"
                                    type="date"
                                    value={startDate}
                                    onChange={(e) => setStartDate(e.target.value)}
                                    InputLabelProps={{
                                        shrink: true,
                                    }}
                                    fullWidth
                                    color="primary"
                                />
                            </Grid>
                            <Grid item xs={6}>
                                <TextField
                                    label="Fecha final"
                                    type="date"
                                    value={endDate}
                                    onChange={(e) => setEndDate(e.target.value)}
                                    InputLabelProps={{
                                        shrink: true,
                                    }}
                                    fullWidth
                                    color="primary"
                                />
                            </Grid>
                        </Grid>
                    </Box>

                    <Box sx={{mb: 2}}>
                        <Typography variant="subtitle1" gutterBottom>
                            Exportar resumen
                        </Typography>
                        <Typography variant="body2" paragraph>
                            Se exportarán tus datos financieros de acuerdo al formato y fecha seleccionada.
                        </Typography>
                        <Button
                            variant="contained"
                            startIcon={<GetAppIcon/>}
                            onClick={() => console.log('Exportar datos', {exportFormat, startDate, endDate})}
                            color="primary"
                        >
                            Exportar Datos
                        </Button>
                    </Box>
                </Paper>
            </Box>
        </ThemeProvider>
    );
};

export default ManejoDatos;