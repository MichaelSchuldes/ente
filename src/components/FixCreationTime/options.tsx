import React, { ChangeEvent } from 'react';
import { FIX_OPTIONS } from '.';
import { Form } from 'react-bootstrap';
import EnteDateTimePicker from 'components/EnteDateTimePicker';
import { Row, Value } from 'components/Container';
import constants from 'utils/strings/constants';

const Option = ({
    value,
    selected,
    onChange,
    label,
}: {
    value: FIX_OPTIONS;
    selected: FIX_OPTIONS;
    onChange: (e: string | ChangeEvent<any>) => void;
    label: string;
}) => (
    <Form.Check
        name="group1"
        style={{
            margin: '5px 0',
            color: value !== Number(selected) ? '#aaa' : '#fff',
        }}>
        <Form.Check.Input
            style={{ marginTop: '6px' }}
            id={value.toString()}
            type="radio"
            value={value}
            checked={value === Number(selected)}
            onChange={onChange}
        />
        <Form.Check.Label
            style={{ cursor: 'pointer' }}
            htmlFor={value.toString()}>
            {label}
        </Form.Check.Label>
    </Form.Check>
);

export default function FixCreationTimeOptions({ handleChange, values }) {
    return (
        <Form noValidate>
            <Row style={{ margin: '0' }}>
                <Option
                    value={FIX_OPTIONS.DATE_TIME_ORIGINAL}
                    onChange={handleChange('option')}
                    label={constants.DATE_TIME_ORIGINAL}
                    selected={Number(values.option)}
                />
            </Row>
            <Row style={{ margin: '0' }}>
                <Option
                    value={FIX_OPTIONS.DATE_TIME_DIGITIZED}
                    onChange={handleChange('option')}
                    label={constants.DATE_TIME_DIGITIZED}
                    selected={Number(values.option)}
                />
            </Row>
            <Row style={{ margin: '0' }}>
                <Value width="50%">
                    <Option
                        value={FIX_OPTIONS.CUSTOM_TIME}
                        onChange={handleChange('option')}
                        label={constants.CUSTOM_TIME}
                        selected={Number(values.option)}
                    />
                </Value>
                {Number(values.option) === FIX_OPTIONS.CUSTOM_TIME && (
                    <Value width="40%">
                        <EnteDateTimePicker
                            value={values.customTime}
                            onChange={(x: Date) =>
                                handleChange('customTime')(x.toUTCString())
                            }
                        />
                    </Value>
                )}
            </Row>
        </Form>
    );
}
