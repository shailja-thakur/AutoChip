module top_module(
    input clk,
    input [7:0] d,
    input reset,
    output reg [7:0] q);

reg [7:0] q_reg;
reg [7:0] q_next;

always @(negedge clk) begin
    if (reset)
        q_next <= 8'b00110100; // set to 0x34
    else
        q_next <= d;
end

always @(posedge clk) begin
    q_reg <= q_next;
end

assign q = q_reg;

endmodule
