module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);

always @(*)
begin
	if (c == 0)
	begin
		if (a == 0)
		begin
			case (b)
				2'b00: out = d;
				2'b01: out = 0;
				2'b10: out = 1;
				2'b11: out = 1;
			endcase
		end
		else
		begin
			case (b)
				2'b00: out = 0;
				2'b01: out = 0;
				2'b10: out = d;
				2'b11: out = d;
			endcase
		end
	end
	else
	begin
		out = 1;
	end
end

endmodule
