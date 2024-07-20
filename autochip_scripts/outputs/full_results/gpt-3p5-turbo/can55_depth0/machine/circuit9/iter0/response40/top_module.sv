module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);

	always @(posedge clk) begin
		if (a == 1'b1) begin
			q <= 3'b100;
		end else begin
			case (q)
				3'b110: q <= 3'b000;
				default: q <= q + 1;
			endcase
		end
	end

endmodule
