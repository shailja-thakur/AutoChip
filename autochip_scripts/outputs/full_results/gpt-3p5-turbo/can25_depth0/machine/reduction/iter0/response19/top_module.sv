module top_module (
    input [7:0] in,
    output parity
);
    
    // Wire declaration
    wire parity_wire;
    
    // Parity logic
    assign parity_wire = ^in;
    
    // Output assignment
    assign parity = parity_wire;
    
endmodule
