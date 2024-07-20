module top_module(
	input logic clk,
	input logic reset,
	input logic data,
	output logic start_shifting);

	// Internal signals
	logic [3:0] state;
	logic [3:0] next_state;
	
	// Assign next state based on current state and data input
	always_comb
	begin
		case (state)
			3'b000:
				if (data)
					next_state = 3'b001;
				else
					next_state = 3'b000;
			
			3'b001:
				if (data)
					next_state = 3'b011;
				else
					next_state = 3'b000;
			
			3'b011:
				if (data)
					next_state = 3'b011;
				else
					next_state = 3'b110;
			
			3'b110:
				if (data)
					next_state = 3'b111;
				else
					next_state = 3'b000;
			
			3'b111:
				next_state = 3'b111;
			
			default:
				next_state = 3'b000;
		endcase
	end
	
	// Register to hold the current state
	always_ff @(posedge clk, posedge reset)
	begin
		if (reset)
			state <= 3'b000;
		else
			state <= next_state;
	end
	
	// Output assignment
	assign start_shifting = (state == 3'b111) ? 1'b1 : 1'b0;

endmodule
