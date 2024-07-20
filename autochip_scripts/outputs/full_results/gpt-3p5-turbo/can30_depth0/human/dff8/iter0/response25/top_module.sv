module top_module(
    input clk,
    input [7:0] d,
    output reg [7:0] q);

// Create 8 D flip-flops
reg [7:0] q_internal;

always @(posedge clk) begin
    q_internal <= d;
end

assign q = q_internal;

endmodule
