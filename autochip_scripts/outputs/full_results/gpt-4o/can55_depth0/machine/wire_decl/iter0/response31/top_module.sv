module top_module (
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n );

    // Internal wires
    wire w1;
    wire w2;

    // Assign values to the wires
    assign w1 = a & b;
    assign w2 = c & d;
    
    // Assign the output out
    assign out = w1 | w2;
    
    // Assign the complement of the output
    assign out_n = ~out;

endmodule
