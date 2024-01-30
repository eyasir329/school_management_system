import React from "react";
import PortalHead from "./PortalHead";
import "./portal.css";
import AdminSidebar from "./AdminSidebar";
import AdminContent from "./AdminContent";

const Admin = () => {

    return (
        <>
            <section id="admin">
                <div className="container">
                    <PortalHead
                        text="Admin Portal"
                    />
                </div>
            </section>
            <section id="admin-main-content">
                <div className="container">
                    <div className="row">

                        <div className="col-lg-12">
                            <div className="admin-left">
                                <AdminSidebar />
                            </div>
                        </div>

                        <div className="col-lg-12">
                            <div className="admin-right">
                                <AdminContent />
                            </div>
                        </div>

                    </div>
                </div>
            </section>
        </>
    );
};

export default Admin;


