module top_module (
    input clk,
    input x,
    output z
);

    // Declare the D flip-flops
    reg d1, d2, d3;
    
    // Combinational logic for the input gates
    wire xor_out = x ^ d1;
    wire and_out = x & ~d2;
    wire or_out = x | ~d3;
    
    // Sequential logic for the D flip-flops
    always @(posedge clk) begin
        d1 <= xor_out;
        d2 <= and_out;
        d3 <= or_out;
    end
    
    // Combinational logic for the output XNOR gate
    assign z = ~(xor_out ^ and_out ^ or_out);

endmodule
