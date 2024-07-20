module top_module (
	input clk,
	input in,
	input reset,
	output out
);
 
reg [1:0] state;
 
always @(posedge clk or posedge reset)
begin
	if (reset)
		state <= 2'b00; // Reset to state A
	else
	begin
		case (state)
			2'b00: // State A
			begin
				if (in)
					state <= 2'b01; // Next state if in=1 is B
				else
					state <= 2'b00; // Next state if in=0 is A
			end
			2'b01: // State B
			begin
				if (in)
					state <= 2'b01; // Next state if in=1 is B
				else
					state <= 2'b10; // Next state if in=0 is C
			end
			2'b10: // State C
			begin
				if (in)
					state <= 2'b01; // Next state if in=1 is A
				else
					state <= 2'b11; // Next state if in=0 is D
			end
			2'b11: // State D
			begin
				if (in)
					state <= 2'b10; // Next state if in=1 is C
				else
					state <= 2'b01; // Next state if in=0 is B
			end
		endcase
	end
end
 
assign out = (state == 2'b11) ? 1'b1 : 1'b0; // Output is 1 when state is D, otherwise 0
 
endmodule
