module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);
	// create a 3-bit register to store the current state
	reg [2:0] state;

	// create a local wire to represent the next state
	wire [2:0] next_state;

	// create a local wire to represent the output
	wire o;

	// assign the output signal based on the current state and input signal
	assign o = (state == 2) ? 1'b1 : 1'b0;

	// create a combinational logic block to determine the next state based on the current state and input signal
	always @(*)
	begin
		case (state)
			0: if (!aresetn) next_state = 0; else if (x) next_state = 1; else next_state = 0;
			1: if (x) next_state = 2; else next_state = 0;
			2: if (x) next_state = 2; else next_state = 0;
			default: next_state = 0;
		endcase
	end

	// create a sequential logic block to update the current state and output signal based on the next state
	always @(posedge clk or negedge aresetn)
	begin
		if (!aresetn)
		begin
			state <= 0;
			z <= 0;
		end
		else
		begin
			state <= next_state;
			z <= o;
		end
	end
endmodule
