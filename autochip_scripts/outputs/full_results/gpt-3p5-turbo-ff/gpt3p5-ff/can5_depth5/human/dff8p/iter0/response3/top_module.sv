module top_module (
    input clk,
    input [7:0] d,
    input reset,
    output reg [7:0] q
);

reg [7:0] q_reg;

// D flip-flops with active high synchronous reset
always @(negedge clk) begin
    if (reset)
        q_reg <= 8'b00110100; // reset value is 0x34
    else
        q_reg <= d;
end

assign q = q_reg;

endmodule
