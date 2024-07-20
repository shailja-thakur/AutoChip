module top_module(
    input clk,
    input d,
    output reg q
);

reg d_dly;

always @(posedge clk) begin
    d_dly <= d;
    q <= (d ^ d_dly);
end

endmodule
