module top_module(
    input clk,
    input d,
    output reg q
);

    reg d_reg1, d_reg2;

    always @(posedge clk or negedge clk) begin
        if (clk) begin
            d_reg1 <= d;
            d_reg2 <= d_reg1;
            q <= (d_reg1 ^ d_reg2);
        end
    end

endmodule
