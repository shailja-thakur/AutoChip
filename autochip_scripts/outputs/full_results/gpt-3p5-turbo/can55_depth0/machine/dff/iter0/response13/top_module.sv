module top_module(
    input clk,
    input d,
    output reg q);

    reg q;

    always @(posedge clk)
    begin
        q <= d;
    end

    initial
    begin
        q <= 1'hx;
    end

endmodule
