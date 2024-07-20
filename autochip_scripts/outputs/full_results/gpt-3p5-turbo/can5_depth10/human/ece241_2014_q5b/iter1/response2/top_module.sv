module top_module (
	input clk,
	input areset,
	input x,
	output z
);

	reg [1:0] state_next, state_current;
	reg reset_triggered;

	parameter A = 2'b00;
	parameter B = 2'b01;

	always @(posedge clk)
	begin
		if (areset)
		begin
			state_current <= A;
			reset_triggered <= 1'b1;
		end
		else
		begin
			if (reset_triggered)
			begin
				state_current <= A;
				reset_triggered <= 1'b0;
			end
			else
				state_current <= state_next;
		end
	end

	always @(state_current or x)
	begin
		case (state_current)
			A: begin
				if (x)
					state_next = B;
				else
					state_next = A;
			end

			B: begin
				if (x)
					state_next = B;
				else
					state_next = B;
			end
		endcase
	end

	assign z = (state_current == B) ? 1'b0 : 1'b1;

endmodule
