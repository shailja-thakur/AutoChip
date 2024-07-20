module top_module(
    input clk,
    input d,
    output reg q
);

    reg d_reg;

    always @(posedge clk, negedge clk) begin
        if (clk) begin
            d_reg <= d;
            q <= d_reg;
        end
    end

endmodule
