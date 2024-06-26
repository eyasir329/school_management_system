import { useRouteError } from "react-router-dom";
import Header from "../components/header/Header";
import Footer from "../components/Footer";

export default function ErrorPage() {
  const error = useRouteError();
  console.error(error);

  return (
    <div>
      <Header />
      <div id="error-page">
        <div className="container">
          <div className="row">
            <div className="col-lg-12">
              <h1>Oops!</h1>
              <p style={{color:"#000"}}>Sorry, an unexpected error has occurred.</p>
              <p style={{color:"#000"}}>
                <i>{error.statusText || error.message}</i>
              </p>
            </div>
          </div>
        </div>
      </div>
      <Footer />
    </div>
  );
}

