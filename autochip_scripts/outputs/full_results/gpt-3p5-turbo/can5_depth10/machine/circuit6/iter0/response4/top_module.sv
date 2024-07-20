module top_module (
	input [2:0] a, 
	output reg [15:0] q
);

	always @(a)
	begin
		case(a)
			3'd0: q = 16'h1232;
			3'd1: q = 16'hAE80;
			3'd2: q = 16'h27B4;
			3'd3: q = 16'hE9A6;
			3'd4: q = 16'h206A;
			3'd5: q = 16'h6492;
			3'd6: q = 16'hC5AE;
			3'd7: q = 16'h2F69;
		endcase
	end
	
endmodule
