#################################################
# convenience notes
# export FLASK_APP=SQLhw_Climate_App.py
# flask run
#################################################

import numpy as np
import pandas as pd
import datetime as dt
from datetime import date
import sqlalchemy
from sqlalchemy.ext.automap import automap_base
from sqlalchemy.orm import Session
from sqlalchemy import create_engine, func, MetaData

from flask import Flask, jsonify

#################################################
# Database Setup
#################################################
engine = create_engine("sqlite:///Resources/hawaii.sqlite", connect_args={'check_same_thread': False}, echo=True)

# reflect an existing database into a new model
Base = automap_base()
# reflect the tables
Base.prepare(engine, reflect=True)
#print(Base.classes.keys()) 
# Save reference to the table
Measurement = Base.classes.measurement
Station = Base.classes.station
# Create our session (link) from Python to the DB
session = Session(engine)

#################################################
# Flask Setup
#################################################
app = Flask(__name__)

#################################################
# Flask Routes
#################################################

@app.route("/")
def home():
    """List all available api routes."""
    return (
        f"Welcome to my Homepage! <br/>"
        f"Available Routes: <br/>"
        f"/api/v1.0/precipitation <br/>"
        f"/api/v1.0/stations <br/>"
        f"/api/v1.0/tobs <br/>"
        f"/api/v1.0/2017-06-24 <br/>"
        f"/api/v1.0/2016-11-01/2016-11-30"
    )

@app.route("/api/v1.0/precipitation")
def precipitation():
    """Return list of dates and prcp values."""

    # Query all tobs 
    Precipitation = session.query(Measurement.date, Measurement.prcp).all()

    # Create a dictionary from the row data and append to a list of all data points
    all_prcp_scores = []
    for date, prcp in Precipitation:
        prcp_dict = {}
        prcp_dict["date"] = date
        prcp_dict["prcp"] = prcp
        all_prcp_scores.append(prcp_dict)

    return jsonify(all_prcp_scores)

@app.route("/api/v1.0/stations")
def stations():
    """Return a list of all station names"""
    # Query all stations
    station_list = session.query(Station.name).all()

    # Convert list of tuples into normal list
    station_names = list(np.ravel(station_list))

    return jsonify(station_names)

@app.route("/api/v1.0/tobs")
def temp():
    """Return a  JSON list of Temperature Observations (tobs) for the previous year."""
    #find last date and calculate PY last date
    last_date = session.query(Measurement.date).order_by(Measurement.date.desc()).first()[0]
    last_date_CY=dt.datetime.strptime(last_date, '%Y-%m-%d')
    last_date_PY=last_date_CY - dt.timedelta(days=365)  
    
    #Query 12 mo tobs
    temp_data = session.query(Measurement.date, Measurement.tobs).filter(Measurement.date >last_date_PY)

    # Convert list of tuples into normal list
    year_temps = list(temp_data)

    return jsonify(year_temps)

@app.route("/api/v1.0/<start>")
def start_temps(start):
    """Return a  JSON list of TMIN, TAVG, TMIN for the noted period of time."""
    #the date for the query is set in step 1 - list of all routes         
    #Query stats as of noted date forward
    temp=[Measurement.date, func.min(Measurement.tobs), func.avg(Measurement.tobs), func.max(Measurement.tobs)]
    temp_start=session.query(*temp).filter(Measurement.date>=start).group_by(Measurement.date).all()
    
    #write result to a list  
    temp_start_list=list(temp_start)
    return jsonify(temp_start_list)

@app.route("/api/v1.0/<start>/<end>")
def nov_temps(start, end):
    """Return a  JSON list of TMIN, TAVG, TMIN for the noted period of time."""
    #the dates for the query are set in step 1 - list of all routes  
    #Query stats for stated period
    temp=[Measurement.date, func.min(Measurement.tobs), func.avg(Measurement.tobs), func.max(Measurement.tobs)]
    temp_stats=session.query(*temp).filter(Measurement.date>=start).\
        filter(Measurement.date<=end).group_by(Measurement.date).all()  
    
    #write result to a list  
    temp_stats_list=list(temp_stats)
    return jsonify(temp_stats_list)

if __name__ == "__main__":
    app.run(debug=True)