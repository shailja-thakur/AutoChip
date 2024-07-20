module top_module (
    input clk,
    input x,
    output z
);

    // Declare D flip-flops
    reg d1, d2, d3;
    
    // Declare XOR, AND, and OR gates
    wire xor_output, and_output, or_output;
    
    // Declare XNOR gate
    assign z = ~(d1 & d2 & d3);
    
    // Connect XOR gate to flip-flop and input
    assign xor_output = x ^ d1;
    
    // Connect AND gate to flip-flop and input
    assign and_output = x & (~d2);
    
    // Connect OR gate to flip-flop and input
    assign or_output = x | (~d3);
    
    // Connect flip-flop outputs to XNOR gate inputs
    always @(posedge clk) begin
        d1 <= xor_output;
        d2 <= and_output;
        d3 <= or_output;
    end
endmodule
