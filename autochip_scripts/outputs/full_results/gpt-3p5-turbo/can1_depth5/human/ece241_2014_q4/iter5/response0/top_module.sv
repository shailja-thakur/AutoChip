module top_module (
    input clk,
    input x,
    output reg z
);

    // Flip-flop outputs
    reg d_reg;

    // Logic gates
    wire xor_out;
    wire and_out;
    wire or_out;

    // Flip-flops
    always @(posedge clk) begin
        d_reg <= x;
    end

    // Logic gates
    assign xor_out = d_reg ^ d_reg;
    assign and_out = ~d_reg & d_reg;
    assign or_out = ~d_reg | d_reg;

    // XNOR gate
    assign z = ~(xor_out ^ and_out ^ or_out);

endmodule
