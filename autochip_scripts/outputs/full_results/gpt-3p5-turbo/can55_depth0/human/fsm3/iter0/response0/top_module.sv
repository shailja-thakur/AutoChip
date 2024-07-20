module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg [1:0] state, next_state;
reg out;

always @(posedge clk or posedge areset)
begin
	if (areset)
	begin
		state <= 2'b00; // Reset to state A
	end
	else
	begin
		state <= next_state;
	end
end

always @*
begin
	case (state)
		2'b00: // State A
		begin
			if (in)
			begin
				next_state = 2'b01; // Next state is B
				out = 1'b0; // Output is 0
			end
			else
			begin
				next_state = 2'b00; // Next state is A
				out = 1'b0; // Output is 0
			end
		end
		
		2'b01: // State B
		begin
			if (in)
			begin
				next_state = 2'b01; // Next state is B
				out = 1'b0; // Output is 0
			end
			else
			begin
				next_state = 2'b10; // Next state is C
				out = 1'b0; // Output is 0
			end
		end
		
		2'b10: // State C
		begin
			if (in)
			begin
				next_state = 2'b11; // Next state is D
				out = 1'b0; // Output is 0
			end
			else
			begin
				next_state = 2'b00; // Next state is A
				out = 1'b0; // Output is 0
			end
		end
		
		2'b11: // State D
		begin
			if (in)
			begin
				next_state = 2'b10; // Next state is C
				out = 1'b1; // Output is 1
			end
			else
			begin
				next_state = 2'b01; // Next state is B
				out = 1'b0; // Output is 0
			end
		end
	endcase
end

endmodule
