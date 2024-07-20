module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);
	reg [2:0] q;
	
	always @(posedge clk) begin
		if (a == 1) begin
			case (q)
				3'd0: q <= 3'd4;
				3'd4: q <= 3'd5;
				3'd5: q <= 3'd6;
				default: q <= 3'd0;
			endcase
		end else begin
			q <= 3'd1;
		end
	end
endmodule
