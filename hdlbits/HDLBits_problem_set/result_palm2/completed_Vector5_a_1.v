module top_module (
    input a, b, c, d, e,
    output [24:0] out );//

    // The output is XNOR of two vectors created by 
    // concatenating and replicating the five inputs.
    // assign out = ~{ ... } ^ { ... };
    // Insert your code below
    
    assign out = ~({a, a, a, a, a, b, b, b, b, b, c, c, c, c, c, d, d, d, d, d, e, e, e, e, e}) ^ ({a, b, c, d, e, a, b, c, d, e, a, b, c, d, e, a, b, c, d, e, a, b, c, d, e});

endmodule