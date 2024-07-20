module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);

always @(posedge clk) begin
	if (a == 1'b1) begin
		if (q == 3'b100) begin
			q <= 3'b010;
		end
		else if (q == 3'b010) begin
			q <= 3'b011;
		end
		else if (q == 3'b011) begin
			q <= 3'b110;
		end
		else begin
			q <= 3'b000;
		end
	end
	else begin
		q <= 3'b100;
	end
end

endmodule
