module top_module(
    input a, 
    input b,
    input c,
    output out
);
    
    // Define intermediate wires
    wire wire1, wire2;
    
    // Implement the circuit described by the Karnaugh map
    assign wire1 = a & b;
    assign wire2 = ~c;
    assign out = wire1 | wire2;
    
endmodule
