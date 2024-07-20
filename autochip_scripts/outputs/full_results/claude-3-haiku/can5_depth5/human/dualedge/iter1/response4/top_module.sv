module top_module(
    input clk,
    input d,
    output reg q
);

    reg d_reg;

    always @(posedge clk, negedge clk) begin
        d_reg <= d;
        q <= (clk ^ d_reg);
    end

endmodule
