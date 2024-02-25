import React, { useEffect, useState } from "react";
import {
    TextField,
    Button,
    Stack,
    FormControl,
    InputLabel,
    Select,
    MenuItem,
    Paper,
    createTheme,
    ThemeProvider,
} from "@mui/material";

import Image from "../../../components/functionality/Image";

const theme = createTheme();

const divisions = ["Barishal", "Chattogram", "Dhaka", "Khulna", "Mymensingh", "Rajshahi", "Rangpur", "Sylhet"];
const divisionMenuItems = divisions.map((division, index) => (
    <MenuItem key={index} value={division}>{division}</MenuItem>
));

export default function TeacherProfile(props) {
    const [editableData, setEditableData] = useState({
        teacherId: "",
        firstName: "",
        lastName: "",
        email: "",
        dateOfBirth: "",
        phoneNumber: "",
        joiningDate: "",
        position: "",
        salary: "",
        facebook: "",
        linkedin: "",
        streetAddress: "",
        city: "",
        state: "",
        zip: "",
        profilePicture: ""
    });
    const [updateMessage, setUpdateMessage] = useState("");
    const [refresh, setRefresh] = useState(false);


    useEffect(() => {
        if (props.teacherData && props.teacherData.length > 0) {
            const data = props.teacherData[0];
            setEditableData(data);
        }
    }, [props.teacherData]);

    const handleSubmit = async (event) => {
        event.preventDefault();
        console.log(editableData)
        try {
            const res = await fetch(`http://localhost:5000/api/teacher/teacherProfileUpdate`, {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                },
                credentials: 'include',
                body: JSON.stringify(editableData),
            });

            const data = await res.json();
            console.log(data);
            if (res.ok) {
                setUpdateMessage(data.message);
                setRefresh(!refresh);
            } else {
                setUpdateMessage("Something went wrong");
            }
        } catch (error) {
            console.error('Error updating teacher:', error);
        }
    };

    const handleInputChange = (event) => {
        const { name, value } = event.target;
        setEditableData({ ...editableData, [name]: value });
    };

    const handleUploadSuccess = (downloadURL) => {
        setEditableData({ ...editableData, profilePicture: downloadURL });
    };

    const handleUploadError = (error) => {
        console.error('Image upload error:', error);
    };

    return (
        <div className="teacher-info">
            <div className="create-teacher">
                <Paper
                    sx={{
                        width: '100%',
                        overflow: 'hidden',
                        padding: '10px 15px',
                        backgroundColor: '#ffffff66',
                        mb: 4,
                    }}
                >
                    <form onSubmit={handleSubmit}>
                        <div className="imageSchool">
                            <Image
                                onUploadSuccess={handleUploadSuccess}
                                onUploadError={handleUploadError}
                                defaultValue={editableData.profilePicture}
                            />
                        </div>

                        <TextField
                            type="text"
                            variant="outlined"
                            label="Unique Teacher ID"
                            InputLabelProps={{ shrink: true }}
                            color="secondary"
                            name="teacherId"
                            value={editableData.teacherId}
                            fullWidth
                            required
                            sx={{ mb: 4 }}
                            onChange={handleInputChange}
                        />

                        <Stack spacing={2} direction="row" sx={{ marginBottom: 4 }}>
                            <TextField
                                type="text"
                                variant="outlined"
                                color="secondary"
                                label="First Name"
                                name="firstName"
                                value={editableData.firstName}
                                fullWidth
                                required
                                onChange={handleInputChange}
                            />
                            <TextField
                                type="text"
                                variant="outlined"
                                color="secondary"
                                label="Last Name"
                                name="lastName"
                                value={editableData.lastName}
                                fullWidth
                                required
                                onChange={handleInputChange}
                            />
                        </Stack>
                        <TextField
                            type="email"
                            variant="outlined"
                            color="secondary"
                            label="Email"
                            name="email"
                            value={editableData.email}
                            fullWidth
                            required
                            sx={{ mb: 4 }}
                            onChange={handleInputChange}
                        />
                        <TextField
                            type="tel"
                            variant="outlined"
                            color="secondary"
                            label="Phone Number"
                            name="phoneNumber"
                            value={editableData.phoneNumber}
                            fullWidth
                            required
                            sx={{ mb: 4 }}
                            onChange={handleInputChange}
                        />
                        <Stack spacing={2} direction="row" sx={{ marginBottom: 4 }}>
                            <TextField
                                type="text"
                                variant="outlined"
                                color="secondary"
                                label="Joining Date"
                                InputLabelProps={{ shrink: true }}
                                className="no-shrink-label"
                                name="joiningDate"
                                value={editableData.joiningDate}
                                fullWidth
                                onChange={handleInputChange}
                            />
                            
                            <TextField
                                type="text"
                                variant="outlined"
                                color="secondary"
                                label="Position"
                                name="position"
                                value={editableData.position}
                                fullWidth
                                onChange={handleInputChange}
                            />


                            <TextField
                                type="number"
                                variant="outlined"
                                color="secondary"
                                label="Salary"
                                name="salary"
                                value={editableData.salary}
                                fullWidth
                                onChange={handleInputChange}
                            />
                        </Stack>
                        <Stack spacing={2} direction="row" sx={{ marginBottom: 4 }}>
                            <TextField
                                type="url"
                                variant="outlined"
                                color="secondary"
                                label="Facebook"
                                name="facebook"
                                value={editableData.facebook}
                                fullWidth
                                onChange={handleInputChange}
                            />
                            <TextField
                                type="url"
                                variant="outlined"
                                color="secondary"
                                label="Linkedin"
                                name="linkedin"
                                value={editableData.linkedin}
                                fullWidth
                                onChange={handleInputChange}
                            />
                        </Stack>
                        <TextField
                            type="text"
                            variant="outlined"
                            color="secondary"
                            label="Date Of Birth"
                            InputLabelProps={{ shrink: true }}
                            name="dateOfBirth"
                            value={editableData.dateOfBirth}
                            fullWidth
                            sx={{ mb: 4 }}
                            onChange={handleInputChange}
                        />

                        <Stack spacing={2} direction="row" sx={{ marginBottom: 4 }}>
                            <TextField
                                label="City"
                                type="text"
                                variant="outlined"
                                color="secondary"
                                name="city"
                                value={editableData.city}
                                fullWidth
                                margin="normal"
                                onChange={handleInputChange}
                            />
                            <FormControl fullWidth margin="normal">
                                <InputLabel id="inputStateLabel">State</InputLabel>
                                <Select
                                    labelId="inputStateLabel"
                                    InputLabelProps={{ shrink: true }}
                                    id="inputState"
                                    variant="outlined"
                                    color="secondary"
                                    name="state"
                                    onChange={handleInputChange}
                                    value={editableData.state}
                                >
                                    {divisionMenuItems}
                                </Select>
                            </FormControl>
                            <TextField
                                label="Zip"
                                type="text"
                                variant="outlined"
                                color="secondary"
                                name="zip"
                                value={editableData.zip}
                                fullWidth
                                margin="normal"
                                onChange={handleInputChange}
                            />
                        </Stack>

                        <TextField
                            label="Street Address"
                            type="text"
                            variant="outlined"
                            color="secondary"
                            name="streetAddress"
                            value={editableData.streetAddress}
                            fullWidth
                            sx={{ mb: 4 }}
                            onChange={handleInputChange}
                        />

                        <Button variant="outlined" color="secondary" type="submit">
                            Update
                        </Button>
                    </form>
                    <p className="reg-error">{updateMessage}</p>
                </Paper>
            </div>
        </div>
    );
}
