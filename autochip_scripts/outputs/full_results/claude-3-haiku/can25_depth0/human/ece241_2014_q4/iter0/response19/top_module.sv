module top_module (
    input clk,
    input x,
    output z
);

    // Declare the D flip-flops
    reg d1, d2, d3;
    
    // Combinational logic
    wire xor_out, and_out, or_out;
    assign xor_out = x ^ d1;
    assign and_out = x & ~d2;
    assign or_out = x | ~d3;
    
    // Sequential logic
    always @(posedge clk) begin
        d1 <= xor_out;
        d2 <= and_out;
        d3 <= or_out;
    end
    
    // Output logic
    assign z = ~(xor_out ^ and_out ^ or_out);

endmodule
