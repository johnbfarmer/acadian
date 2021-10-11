import React from 'react';
import { Grid, Table, Input, Dropdown } from 'semantic-ui-react';
import Nav from './Nav';
import TopNav from './TopNav';
import tableHelper from './TableHelper';
import { getData, postData } from './DataManager';

const moment = require('moment');

export default class Month extends React.Component {
    constructor(props) {
        super(props);

        let dt = props.match.params.dt || moment().format('YYYYMMDD');

        this.state = {
            data: [],
            date: dt,
            pid: 1,
            columns: [],
            subjects: [],
        };
    }

    componentDidMount() {
        this.handleData();
    }

    handleData() {
        var url = '/acad/month/' + this.state.pid + '/' + this.state.date;
        getData(url)
        .then(data => {
            if (data.data.table.rows.length > 0) {
                let subjects = [];
                data.data.table.rows.forEach ((r, k) => {
                    subjects.push({
                        key: k,
                        text: r.subject,
                        value: r.subject,
                    });
                });
                this.setState({
                    personId: 1,
                    data: data.data.table.rows,
                    columns: data.data.table.columns,
                    subjects: subjects,
                });
            }
            // this.loading(false);
        });
    }

    formatDate(yyyymmdd) {
        return yyyymmdd.substring(0,4) + '-' + yyyymmdd.substring(4,6) + '-01';
    }

    displayDateColumn(vals, rowIdx, colIdx) {
        let val = vals.date;
        let display = null;
        if (vals.is_total === '1') {
            display = (
                <div className="acad-bold">
                    { val }
                </div>
            );
        } else {
            let url = '/dt/' + moment(val).format('YYYYMMDD');
            display = (
                <a href={url}>
                    { val }
                </a>
            )
        }
        return (
            <Table.Cell key={'dd_' + rowIdx + '_' + colIdx}>
                { display }
            </Table.Cell>
        )
    }

    render() {
        let dt = this.formatDate(this.state.date);
        var propsForTable = {
            data: this.state.data,
            columns: this.state.columns,
            specialCols: {
                'date': this.displayDateColumn,
            }
        }
        var tbl = tableHelper.tablify(propsForTable);
        let topNavProps = JSON.parse(JSON.stringify(this.props));
        topNavProps.title = moment(dt).format('MMM YYYY');
        topNavProps.prevLink = '/month/' + moment(dt).subtract(1, 'months').format('YYYYMMDD');
        topNavProps.nextLink = '/month/' + moment(dt).add(1, 'months').format('YYYYMMDD');
        return (
            <div>
                <Grid>
                    <Grid.Row>
                        <Grid.Column width={3}>
                            <Nav date={dt}/>
                        </Grid.Column>
                        <Grid.Column width={13}>
                            <Grid.Row>
                                <Grid.Column centered="true">
                                    <TopNav { ...topNavProps } />
                                </Grid.Column>
                            </Grid.Row>
                            {tbl}
                        </Grid.Column>
                    </Grid.Row>
                </Grid>
            </div>
        );
    }
}
