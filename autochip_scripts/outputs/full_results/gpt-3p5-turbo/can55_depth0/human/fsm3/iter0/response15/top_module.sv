module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg [1:0] state, next_state;
reg out;

always @(posedge clk, posedge areset)
begin
	if (areset)
		state <= 2'b00;
	else
		state <= next_state;
end

always @(state, in)
begin
	case (state)
		2'b00:		// State A
		begin
			if (in)
			begin
				next_state = 2'b01;	// Next state = B
				out = 1'b0;		// Output = 0
			end
			else
			begin
				next_state = 2'b00;	// Next state = A
				out = 1'b0;		// Output = 0
			end
		end
		
		2'b01:		// State B
		begin
			if (in)
			begin
				next_state = 2'b10;	// Next state = C
				out = 1'b0;		// Output = 0
			end
			else
			begin
				next_state = 2'b01;	// Next state = B
				out = 1'b0;		// Output = 0
			end
		end
		
		2'b10:		// State C
		begin
			if (in)
			begin
				next_state = 2'b00;	// Next state = A
				out = 1'b0;		// Output = 0
			end
			else
			begin
				next_state = 2'b11;	// Next state = D
				out = 1'b0;		// Output = 0
			end
		end
		
		2'b11:		// State D
		begin
			if (in)
			begin
				next_state = 2'b10;	// Next state = C
				out = 1'b1;		// Output = 1
			end
			else
			begin
				next_state = 2'b01;	// Next state = B
				out = 1'b0;		// Output = 0
			end
		end
	endcase
end

endmodule
