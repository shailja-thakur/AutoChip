module top_module(
    input clk,
    input [7:0] d,
    output reg [7:0] q
);

    reg [7:0] q_internal;

    always @(posedge clk) begin
        q_internal <= d;
    end

    always @(posedge clk) begin
        q <= q_internal;
    end

endmodule
