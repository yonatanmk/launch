import React from 'react';

const Form = props => {
  return(
    <div className="row search">
        <form>
          <div className="input-field col s3">
            <input type="text" name="name" placeholder="Enter name here..." onChange={props.handleNameChange}/>
          </div>
          <div className="input-field col s3">
            <select name="category" className="browser-default" onChange={props.handleCategoryChange}>
              <option value="American">American</option>
              <option value="Tex-Mex">Tex-Mex?</option>
              <option value="Hamburger">Hamburger</option>
              <option value="Fish">Fish</option>
              <option value="Healthy">Healthy</option>
            </select>
          </div>
          <div className="input-field col s3">
            <input type="text" name="description" placeholder="Enter descriptions here..." onChange={props.handleDescriptionChange}/>
          </div>
          <div className="row">
            <div className="col s2 offset-s5 center-align">
              <input className="btn" type="submit" value="Submit" name="Submit" onClick={props.handleSubmit}/>
            </div>
          </div>
        </form>
    </div>
  )
}

export default Form;
