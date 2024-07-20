module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] pedge);

    reg [7:0] in_reg;
    
    always @(posedge clk) begin
        pedge <= (in & ~in_reg);
        in_reg <= in;
    end

endmodule
