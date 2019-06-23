import React from 'react';
import ReactDOM from 'react-dom';
import { Tab, Tabs, TabList, TabPanel } from 'react-tabs';
import RecentTab from './RecentTab.jsx';
import SummaryTab from './SummaryTab.jsx';
import VitoEdit from './VitoEdit.jsx';
import VitoNav from './VitoNav.jsx';
import Spinner from './Spinner.jsx';
import DialogBox from './DialogBox.jsx';

const maxMetrics = 4;

const metricLabels = {
    'distance': 'Distance',
    'distance_run': 'Distance Run',
    'steps': 'Steps',
    'stepsPerKm': 'Steps/Km',
    'sleep': 'Sleep',
    'weight': 'Weight',
    'abdominals': 'Abdominals',
    'systolic': 'Systolic',
    'diastolic': 'Diastolic',
    'bp': 'Blood Pressure',
    'pulse': 'Pulse',
    'za': 'ZA',
    // 'tobacco': 'Tobacco',
};

export default class Vito extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            numUnits: 6,
            personId: 0,
            recordId: 0,
            people: [{id:1, name: 'John'},{id:2, name: 'Ian'},{id:3, name: 'Pily'},{id:4, name: 'Choco'}],
            agg: 'months',
            selectedChartMetrics: ['distance_run'],
            availableChartMetrics: ['bp', 'weight'],
            view: 'recent',
            showDialog: false,
            dialogMessage: '',
            dialogTitle: '',
            makeApiCall: true,
            data: {},
            refreshChart: false,
            showChart: false,
            loading: true,
        };

        this.updatePerson = this.updatePerson.bind(this);
        this.updateRecord = this.updateRecord.bind(this);
        this.updateAggUnits = this.updateAggUnits.bind(this);
        this.updateAgg = this.updateAgg.bind(this);
        this.updateSelectedChartMetrics = this.updateSelectedChartMetrics.bind(this);
        this.updateAvailableChartMetrics = this.updateAvailableChartMetrics.bind(this);
        this.updateView = this.updateView.bind(this);
        this.updateLoading = this.updateLoading.bind(this);
        this.getViewTag = this.getViewTag.bind(this);
        this.updateRefreshChart = this.updateRefreshChart.bind(this);
        this.closeDialog = this.closeDialog.bind(this);
        this.updateState = this.updateState.bind(this);
    }

    updatePerson(e) {
        var dataset = e.target.dataset;
        var id = dataset.id;
        this.setState({makeApiCall: true, personId: id});
    }

    updateRecord(e) {
        var dataset = e.target.parentNode.dataset;
        var id = dataset.id;
        console.log(id);
        this.setState({makeApiCall: true, view: 'edit', recordId: id});
    }

    updateAggUnits(n) {
        this.setState({makeApiCall: true, numUnits: n});
    }

    updateAgg(e) {
        var dataset = e.target.dataset;
        var agg = dataset.agg;
        this.setState({makeApiCall: true, agg: agg});
    }

    updateSelectedChartMetrics(e) {
        var dataset = e.target.dataset;
        var metric = dataset.metric;
        var metrics = this.state.selectedChartMetrics;
        var pos = metrics.indexOf(metric);
        if (pos >= 0) {
            metrics.splice(pos, 1);
        } else {
            metrics.push(metric);
        }

        if (metrics.length > maxMetrics) {
            metrics.shift();
        }

        this.setState({makeApiCall: false, selectedChartMetrics: metrics, refreshChart: true});
    }

    updateAvailableChartMetrics(m) {
        this.setState({makeApiCall: false, availableChartMetrics: m});
    }

    updateView(e) {
        var dataset = e.target.dataset;
        var view = dataset.view;
        this.setState({makeApiCall: true, view: view});
    }

    updateRefreshChart(b) {
        this.setState({refreshChart: b});
    }

    updateLoading(loading) {
        this.setState({makeApiCall: false, loading: loading});
    }

    updateState(st) {
        this.setState(st);
    }

    common() {
        return {
            personId: this.state.personId,
            recordId: this.state.recordId,
            numUnits: this.state.numUnits,
            data: this.state.data,
            people: this.state.people,
            updatePerson: this.updatePerson,
            updateRecord: this.updateRecord,
            updateAggUnits: this.updateAggUnits,
            agg: this.state.agg,
            updateAgg: this.updateAgg,
            refreshChart: this.state.refreshChart,
            updateRefreshChart: this.updateRefreshChart,
            selectedChartMetrics: this.state.selectedChartMetrics,
            updateSelectedChartMetrics: this.updateSelectedChartMetrics,
            availableChartMetrics: this.state.availableChartMetrics,
            updateAvailableChartMetrics: this.updateAvailableChartMetrics,
            view: this.state.view,
            updateView: this.updateView,
            updateLoading: this.updateLoading,
            useAgg: this.state.view === 'summary',
            makeApiCall: this.state.makeApiCall,
            updateState: this.updateState,
            metricLabels: metricLabels,
            showChart: this.state.showChart,
        };
    }

    getViewTag() {
        var common = this.common();
        switch (this.state.view) {
            case 'recent':
                return (
                    <RecentTab 
                        loader={this.setLoader}
                        updatePerson={this.updatePerson}
                        common={common}
                    />
                );
            case 'summary':
                return (
                    <SummaryTab 
                        loader={this.setLoader}
                        updatePerson={this.updatePerson}
                        common={common}
                    />
                );
            default:
                return (
                    <VitoEdit 
                        loader={this.setLoader}
                        updatePerson={this.updatePerson}
                        common={common}
                    />
                );
        }
    }

    closeDialog() {
        this.setState({showDialog: false});
    }

    render() {
        var common = this.common();
console.log(common)
        var viewTag = this.getViewTag();
        return (
            <div>
                <div className="col-md-1">
                    <VitoNav common={common} />
                </div>
                <div className="col-md-11">
                    {viewTag}
                </div>
                <Spinner show={this.state.loading} />
                <DialogBox msg={this.state.dialogMessage} title={this.state.dialogTitle} show={this.state.showDialog} close={this.closeDialog} agree={this.closeDialog}/>
            </div>
        );
    }
}



ReactDOM.render(<Vito />, document.getElementById("content"));