module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);
    // Implement the circuit described by the Karnaugh map
    
    // Intermediate signals
    wire ab;
    wire cd;
    
    // Assign signals
    assign ab = a & b;
    assign cd = c & d;
    
    // Output equation
    assign out = ab | ~cd;
    
endmodule
