module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);
	reg [2:0] next_q;
	always @(posedge clk) begin
		if (a) begin
			next_q <= 4;
		end else begin
			case (q)
				3'b110: next_q <= 3'b000;
				default: next_q <= q + 1;
			endcase
		end
	end
	
	always @(posedge clk) begin
		q <= next_q;
	end
endmodule
