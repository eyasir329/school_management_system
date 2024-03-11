const express = require("express");
const { adminProfile, createPosition, viewPosition, updatePosition,schoolCreateOrUpdate, schoolView, createNotice, viewNotice, updateNotice, deleteNotice, createAcademic, viewAcademic, updateAcademic, deleteAcademic, createClassSubject, viewClassSubject, updateClassSubject, deleteClassSubject } = require("../controllers/admin.controller");
// const { schoolCreateOrUpdate, schoolView, createTeacher, lastTeacherId, viewTeacher, updateTeacher, deleteTeacher, createStaff, lastStaffId, viewStaff, updateStaff, deleteStaff, createAcademic, viewAcademic, updateAcademic, deleteAcademic, createSubject, viewSubject, updateSubject, deleteSubject, createStudent, lastStudentId, updateStudent, deleteStudent, viewStudent, createOrUpdatePrincipal, viewPrincipal, viewNotice, createNotice, updateNotice, deleteNotice } = require("../controllers/admin.controller");

const router = express.Router();

// admin profile
router.post("/adminProfile", adminProfile);
router.post("/createPosition", createPosition);
router.get("/viewPosition", viewPosition);
router.put("/updatePosition/:position_id", updatePosition);

// school information
router.post("/schoolCreateOrUpdate", schoolCreateOrUpdate);
router.get("/schoolView", schoolView);

// notice board
router.get('/viewNotices', viewNotice);
router.post('/createNotice', createNotice);
router.put('/notices/:noticeId', updateNotice);
router.delete('/notices/:noticeId', deleteNotice);

// // Teacher endpoints
// router.get("/lastTeacherId", lastTeacherId);
// router.post("/createTeacher", createTeacher);
// router.get("/viewTeacher", viewTeacher);
// router.post("/updateTeacher", updateTeacher);
// router.delete('/deleteTeacher/:teacherId', deleteTeacher);

// // Staff endpoints
// router.post("/createStaff", createStaff);
// router.get("/lastStaffId", lastStaffId);
// router.get("/viewStaff", viewStaff);
// router.post("/updateStaff", updateStaff);
// router.delete('/deleteStaff/:staffId', deleteStaff);

// Academic endpoints
router.post("/createAcademic", createAcademic);
router.get("/viewAcademic", viewAcademic);
router.post("/updateAcademic", updateAcademic);
router.delete("/deleteAcademic", deleteAcademic);

// // subject 
router.post("/createClassSubject", createClassSubject);
router.get("/viewClassSubject", viewClassSubject);
router.post("/updateClassSubject", updateClassSubject);
router.delete("/deleteClassSubject/:classSubjectId", deleteClassSubject);

// // student
// router.post("/createStudent", createStudent);
// router.get("/lastStudentId", lastStudentId);
// router.post("/updateStudent", updateStudent);
// router.delete('/deleteStudent/:studentId', deleteStudent);
// router.get('/viewStudent', viewStudent);

// // principal
// router.post('/createOrUpdatePrincipal', createOrUpdatePrincipal);
// router.get('/viewPrincipal', viewPrincipal);




module.exports = router;
