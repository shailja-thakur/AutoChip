
	always @(*) begin
		case (do_sub)
			0: out = a + b;
			1: out = a - b;
		endcase
		result_is_zero = (out == 0);
	end
	
endmodule
