import React, { useState, useEffect } from 'react';
import Paper from '@mui/material/Paper';
import Table from '@mui/material/Table';
import TableBody from '@mui/material/TableBody';
import TableCell from '@mui/material/TableCell';
import TableContainer from '@mui/material/TableContainer';
import TableHead from '@mui/material/TableHead';
import TablePagination from '@mui/material/TablePagination';
import TableRow from '@mui/material/TableRow';
import { Button, Dialog, DialogActions, DialogContent, DialogTitle, TextField } from '@mui/material';
import Image from '../../../components/functionality/Image';

const columns = [
    { id: 'userId', label: 'User ID', minWidth: 50 },
    { id: 'type', label: 'Type', minWidth: 50 },
    { id: 'email', label: 'Email', minWidth: 150 },
    { id: 'key', label: 'Key', minWidth: 150 },
    { id: 'status', label: 'Status', minWidth: 50 },
    { id: 'mail', label: 'Request', minWidth: 50 },
    { id: 'created_at', label: 'created_at', minWidth: 100 },
    { id: 'updated_at', label: 'updated_at', minWidth: 100 },
];

const UserStatus = () => {
    const [page, setPage] = useState(0);
    const [rowsPerPage, setRowsPerPage] = useState(10);
    const [editableData, setEditableData] = useState(null);
    const [openDialog, setOpenDialog] = useState(false);
    const [searchId, setSearchId] = useState('');
    const [filteredData, setFilteredData] = useState([]);
    const [teacherData, setTeacherData] = useState([]);
    const [updateMessage, setUpdateMessage] = useState("");
    const [deleteMessage, setDeleteMessage] = useState("");

    useEffect(() => {
        fetchData();
    }, []);

    const fetchData = async () => {
        try {
            const response = await fetch('http://localhost:5000/api/admin/viewTeacher');
            if (!response.ok) {
                throw new Error('Failed to fetch teacher data');
            }
            const data = await response.json();

            setTeacherData(data);
            setFilteredData(data);
        } catch (error) {
            console.error('Error fetching teacher data:', error);
        }
    };

    const handleChangePage = (event, newPage) => {
        setPage(newPage);
    };

    const handleChangeRowsPerPage = (event) => {
        setRowsPerPage(+event.target.value);
        setPage(0);
    };

    const handleEdit = (row) => {
        setEditableData(row);
        setOpenDialog(true);
    };

    const handleSave = async () => {
        console.log(editableData);
        try {
            const res = await fetch(`http://localhost:5000/api/admin/updateTeacheryuy`, {
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
                fetchData();
            } else {
                setUpdateMessage("something wrong");
            }


        } catch (error) {
            console.error('Error updating teacher:', error);
        }

        setEditableData(null);
        setOpenDialog(false);
    };

    const handleCancel = () => {
        setEditableData(null);
        setOpenDialog(false);
    };

    const handleDelete = async (row) => {
        try {
            const res = await fetch(`http://localhost:5000/api/admin/deleteTeacher/${row.teacherId}`, {
                method: "DELETE",
                credentials: 'include',
            });
            const responseData = await res.json();
            console.log(responseData);
            if (res.ok) {
                setDeleteMessage(responseData.message);
                // Refresh the teacher data after deletion
                fetchData();
            } else {
                setDeleteMessage("Something wrong not to delete that teacherId");
                console.error('Failed to delete teacher:', res.statusText);
            }
        } catch (error) {
            console.error('Error deleting teacher:', error);
        }
    };

    const handleSearch = () => {
        const searchTerm = searchId.toLowerCase().trim();
        const searchResult = teacherData.filter((row) => {
            const teacherIdString = String(row.teacherId);
            return (
                (teacherIdString.includes(searchTerm))
            );
        });
        setFilteredData(searchResult);
    };

    const handleRefresh = () => {
        setSearchId('');
        setFilteredData(teacherData);
        fetchData();
        setUpdateMessage();
        setDeleteMessage();
    };

    return (
        <>
            <div className="teacher-view-ex">
                <div className="teacher-view">
                    <Paper sx={{ width: '100%', overflow: 'hidden', padding: '10px 15px', backgroundColor: '#ffffff66' }}>
                    
                        <TextField
                            label="Search by User ID"
                            value={searchId}
                            onChange={(e) => setSearchId(e.target.value)}
                            fullWidth
                            margin="normal"
                        />

                        <Button onClick={handleSearch} variant="contained" color="primary" sx={{ ml: 2 }}>
                            Search
                        </Button>
                        <Button onClick={handleRefresh} variant="contained" color="secondary" sx={{ ml: 2 }}>
                            Refresh
                        </Button>


                        {/* Table */}
                        <TableContainer sx={{ maxHeight: 540 }}>
                            <Table stickyHeader aria-label="sticky table">
                                <TableHead>
                                    <TableRow>
                                        {columns.map((column) => (
                                            <TableCell
                                                key={column.id}
                                                align="left"
                                                style={{ minWidth: column.minWidth, fontWeight: 'bold', fontSize: '20px', padding: '10px 15px' }}
                                            >
                                                {column.label}
                                            </TableCell>
                                        ))}
                                        <TableCell align="left" style={{ minWidth: 100, fontWeight: 'bold', fontSize: '20px', padding: "10px 15px" }}>
                                            Actions
                                        </TableCell>
                                    </TableRow>
                                </TableHead>
                                <TableBody>
                                    {filteredData
                                        .slice(page * rowsPerPage, page * rowsPerPage + rowsPerPage)
                                        .map((row) => (
                                            <TableRow hover role="checkbox" tabIndex={-1} key={row.teacherId}>
                                                {columns.slice(1).map((column) => (
                                                    <TableCell key={column.id} align="left" sx={{ fontSize: '16px' }}>
                                                        {editableData === row ? (
                                                            <TextField
                                                                value={row[column.id]}
                                                                onChange={(e) => {
                                                                    const updatedData = { ...row, [column.id]: e.target.value };
                                                                    setEditableData(updatedData);
                                                                }}
                                                            />
                                                        ) : (
                                                            row[column.id]
                                                        )}
                                                    </TableCell>
                                                ))}
                                                <TableCell key="actions" align="left" sx={{ fontSize: '16px' }}>
                                                    {editableData !== row && (
                                                        <>
                                                            <Button onClick={() => handleEdit(row)}>Edit</Button>
                                                            <Button onClick={() => handleDelete(row)}>Delete</Button>
                                                        </>
                                                    )}
                                                </TableCell>
                                            </TableRow>
                                        ))}
                                </TableBody>
                            </Table>
                        </TableContainer>


                        {/* Update Dialog */}
                        <Dialog open={openDialog} onClose={handleCancel}>
                            <DialogTitle>Edit Teacher</DialogTitle>
                            <DialogContent>
                                {editableData && columns.map((column) => (
                                    <React.Fragment key={column.id}>

                                        <TextField
                                            label={column.label}
                                            value={editableData[column.id]}
                                            onChange={(e) => {
                                                const updatedData = { ...editableData, [column.id]: e.target.value };
                                                setEditableData(updatedData);
                                            }}
                                            fullWidth
                                            margin="normal"
                                        />

                                    </React.Fragment>
                                ))}
                            </DialogContent>
                            <DialogActions>
                                <Button onClick={handleSave}>Save</Button>
                                <Button onClick={handleCancel}>Cancel</Button>
                            </DialogActions>
                        </Dialog>


                        {/* Pagination */}
                        <TablePagination
                            rowsPerPageOptions={[5, 10, 25, 100]}
                            component="div"
                            count={filteredData.length}
                            rowsPerPage={rowsPerPage}
                            page={page}
                            onPageChange={handleChangePage}
                            onRowsPerPageChange={handleChangeRowsPerPage}
                        />
                    </Paper>
                    <p className="reg-error" style={{ marginTop: "15px" }}>
                        {updateMessage || deleteMessage}
                    </p>
                </div>
            </div>
        </>
    );
};

export default UserStatus;