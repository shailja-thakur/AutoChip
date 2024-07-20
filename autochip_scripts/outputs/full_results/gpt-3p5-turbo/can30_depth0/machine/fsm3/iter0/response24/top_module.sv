module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	// state register
	reg [1:0] state;
	// output register
	reg out_reg;

	// combinational logic block
	always @ (posedge clk, posedge areset)
	begin
		if (areset)
			state <= 2'b00; // reset to state A
		else
		begin
			case (state)
				2'b00: 
					if (in)
						state <= 2'b01; // next state is B
					else
						state <= 2'b00; // next state is A
				2'b01: 
					if (in)
						state <= 2'b01; // next state is B
					else
						state <= 2'b10; // next state is C
				2'b10: 
					if (in)
						state <= 2'b11; // next state is D
					else
						state <= 2'b00; // next state is A
				2'b11:
					if (in)
						state <= 2'b01; // next state is B
					else
						state <= 2'b10; // next state is C
			endcase
		end
	end

	// output assignment
	always @ (state)
	begin
		if (state == 2'b11) // state D
			out_reg <= 1'b1;
		else
			out_reg <= 1'b0;
	end

	// output buffer
	assign out = out_reg;

endmodule
