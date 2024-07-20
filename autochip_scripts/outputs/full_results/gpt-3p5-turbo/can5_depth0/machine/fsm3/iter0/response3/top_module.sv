module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

reg [1:0] state;

always @(posedge clk or posedge areset)
begin
	if (areset)
		state <= 2'b00; // Initialize state to A on reset
	else
	begin
		case (state)
			2'b00: // If state is A
			begin
				if (in)
					state <= 2'b01; // Next state is B if input is 1
				else
					state <= 2'b00; // Next state is A if input is 0
			end
			
			2'b01: // If state is B
			begin
				if (in)
					state <= 2'b01; // Next state is B if input is 1
				else
					state <= 2'b10; // Next state is C if input is 0
			end
			
			2'b10: // If state is C
			begin
				if (in)
					state <= 2'b11; // Next state is D if input is 1
				else
					state <= 2'b00; // Next state is A if input is 0
			end
			
			2'b11: // If state is D
			begin
				if (in)
					state <= 2'b01; // Next state is B if input is 1
				else
					state <= 2'b10; // Next state is C if input is 0
			end
		endcase
	end
end

assign out = (state == 2'b11) ? 1'b1 : 1'b0; // Set out to 1 when state is D

endmodule
