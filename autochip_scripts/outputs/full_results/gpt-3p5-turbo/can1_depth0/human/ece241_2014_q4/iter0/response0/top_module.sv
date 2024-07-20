module top_module (
    input clk,
    input x,
    output z
);

    // D flip-flops
    reg d1, d2, d3;
    initial begin
        d1 = 0;
        d2 = 0;
        d3 = 0;
    end
    
    // XOR, AND, OR gates
    wire xor_out, and_out, or_out;
    assign xor_out = x ^ d1;
    assign and_out = ~(x & d2);
    assign or_out = ~(x | d3);
    
    // XNOR gate
    assign z = ~(xor_out ^ and_out ^ or_out);

    // Clock control
    always @(posedge clk) begin
        d1 <= xor_out;
        d2 <= and_out;
        d3 <= or_out;
    end

endmodule
