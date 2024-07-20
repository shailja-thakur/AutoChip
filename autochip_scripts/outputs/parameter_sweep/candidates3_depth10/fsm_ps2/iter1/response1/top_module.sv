module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [7:0] in_reg;
reg [7:0] in_reg2;
reg [7:0] in_reg3;
reg done_reg;

always @(posedge clk) begin
	if (reset) begin
		in_reg <= 8'b0;
	end
	else begin
		in_reg <= in;
	end
end

always @(posedge clk) begin
	in_reg2 <= in_reg;
end

always @(posedge clk) begin
	in_reg3 <= in_reg2;
end

always @(posedge clk) begin
	if (reset) begin
		done_reg <= 1'b0;
	end
	else if (in_reg3[3] && !in_reg2[3] && !in_reg[3]) begin
		done_reg <= 1'b1;
	end
	else begin
		done_reg <= 1'b0;
	end
end

assign done = done_reg;

endmodule
