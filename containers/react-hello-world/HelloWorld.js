import React from 'react';

const HelloWorld = () => {

    function sayHello() {
        alert('Hello, World!');
    }

    return (
        <button onClick={sayHello}>Click me!</button>
    );
};

export default HelloWorld;