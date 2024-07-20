module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);
	always @(posedge clk) begin
		if (a) begin
			case (q)
				3'b110: q <= 3'b100;
				3'b100: q <= 3'b010;
				default: q <= 3'b001;
			endcase
		end else begin
			case (q)
				3'b000: q <= 3'b000;
				default: q <= q + 1;
			endcase
		end
	end
endmodule
