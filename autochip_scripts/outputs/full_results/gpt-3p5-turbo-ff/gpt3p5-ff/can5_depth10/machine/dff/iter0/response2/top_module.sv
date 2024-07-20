module top_module(
    input clk,
    input d,
    output reg q
);

    always @(posedge clk)
        q <= d;

    initial begin
        q <= 1'hx;
    end
endmodule
