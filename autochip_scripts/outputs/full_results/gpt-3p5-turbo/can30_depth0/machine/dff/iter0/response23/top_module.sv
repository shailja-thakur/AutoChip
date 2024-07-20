module top_module(
    input wire clk,
    input wire d,
    output reg q);

    initial begin
        q = 1'hx;
    end

    always @(posedge clk) begin
        q <= d;
    end

endmodule
