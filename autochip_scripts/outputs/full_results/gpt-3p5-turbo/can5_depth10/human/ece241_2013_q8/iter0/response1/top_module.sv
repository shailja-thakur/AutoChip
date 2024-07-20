module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);
	// Define the states
	typedef enum logic [1:0] {
		IDLE,
		S1,
		S2
	} state_t;

	// Define the signals
	reg [1:0] state;
	reg x_delayed;

	// Flip-flop for x signal
	always @(posedge clk or negedge aresetn) begin
		if (!aresetn)
			x_delayed <= 1'b1;
		else
			x_delayed <= x;
	end

	// Mealy-type FSM
	always @(posedge clk or negedge aresetn) begin
		if (!aresetn)
			state <= IDLE;
		else begin
			case (state)
				IDLE: if (x_delayed == 1'b1)
						state <= S1;
					  else
						state <= IDLE;
				S1: if (x_delayed == 1'b0)
						state <= IDLE;
					 else if (x_delayed == 1'b1)
						state <= S2;
				S2: if (x_delayed == 1'b0)
						state <= S1;
					 else
						state <= IDLE;
				default: state <= IDLE;
			endcase
		end
	end

	// Output generation
	always @(posedge clk or negedge aresetn) begin
		if (!aresetn || state == IDLE)
			z <= 1'b0;
		else if (state == S2)
			z <= 1'b1;
		end
	end
endmodule
