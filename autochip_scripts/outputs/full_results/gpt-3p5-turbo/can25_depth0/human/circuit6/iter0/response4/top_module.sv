module top_module (
    input [2:0] a, 
    output reg [15:0] q
);
	always @* begin
		case (a)
			3'd0: q = 16'd1232;
			3'd1: q = 16'daee0;
			3'd2: q = 16'd27d4;
			3'd3: q = 16'd5a0e;
			3'd4: q = 16'd2066;
			3'd5: q = 16'd64ce;
			3'd6: q = 16'dc526;
			3'd7: q = 16'd2f19;
			default: q = 16'd0;
		endcase
	end
endmodule
