module top_module(
	input clk,
	input slowena,
	input reset,
	output reg [3:0] q);

	always @(posedge clk) begin
		if (reset) begin
			q <= 0;
		end else if (slowena) begin
			case (q)
				4'd0: q <= 4'd1;
				4'd1: q <= 4'd2;
				4'd2: q <= 4'd3;
				4'd3: q <= 4'd4;
				4'd4: q <= 4'd5;
				4'd5: q <= 4'd6;
				4'd6: q <= 4'd7;
				4'd7: q <= 4'd8;
				4'd8: q <= 4'd9;
				4'd9: q <= 4'd0;
				default: q <= 4'd0;
			endcase
		end
	end
endmodule
