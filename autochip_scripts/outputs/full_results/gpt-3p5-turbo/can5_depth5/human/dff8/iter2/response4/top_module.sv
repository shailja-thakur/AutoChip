module top_module(
    input clk,
    input [7:0] d,
    output reg [7:0] q
);

// Create 8 D flip-flops
reg [7:0] q_reg;

// Assign d to q_reg on positive edge of clk
always @(posedge clk)
begin
    q_reg <= d;
end

// Assign q_reg to q on positive edge of clk
always @(posedge clk)
begin
    q <= q_reg;
end

endmodule
