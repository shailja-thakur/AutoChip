module top_module(
    input clk,
    input [7:0] d,
    output reg [7:0] q);

    reg [7:0] d_ff_q;

    always @(posedge clk) begin
        d_ff_q <= d;
        q <= d_ff_q;
    end

endmodule
