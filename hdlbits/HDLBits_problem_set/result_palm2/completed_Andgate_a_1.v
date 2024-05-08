module top_module( 
    input a, 
    input b, 
    output out );

    // The AND gate output is 1 if and only if both inputs are 1.
    assign out = a & b;

endmodule