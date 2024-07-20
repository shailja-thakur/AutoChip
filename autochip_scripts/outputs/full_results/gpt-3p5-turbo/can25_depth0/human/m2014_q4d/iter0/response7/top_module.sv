module top_module (
    input clk,
    input in,
    output logic out
);

    // Create a 2-input XOR gate
    wire xor_out;
    assign xor_out = in ^ out;
    
    // Create a D flip-flop
    reg d;
    always @(posedge clk)
        d <= xor_out;
    
    // Assign the output of the flip-flop to 'out'
    assign out = d;
    
endmodule
