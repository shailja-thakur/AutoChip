module top_module(
    input clk,
    input [7:0] d,
    input reset,
    output reg [7:0] q
);

reg [7:0] q_reg;
reg [7:0] d_reg;

always @(negedge clk or posedge reset) begin
    if (reset)
        q_reg <= 8'b00110100; // Reset to 0x34
    else
        q_reg <= d_reg;
end

always @(posedge clk) begin
    d_reg <= d;
end

assign q = q_reg;

endmodule
