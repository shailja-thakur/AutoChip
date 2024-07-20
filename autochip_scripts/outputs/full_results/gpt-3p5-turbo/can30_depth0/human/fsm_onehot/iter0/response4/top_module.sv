module top_module (
	input in,
	input [9:0] state,
	output [9:0] next_state,
	output out1,
	output out2);

	// Define the states
	localparam S0 = 10'b0000000001;
	localparam S1 = 10'b0000000010;
	localparam S2 = 10'b0000000100;
	localparam S3 = 10'b0000001000;
	localparam S4 = 10'b0000010000;
	localparam S5 = 10'b0000100000;
	localparam S6 = 10'b0001000000;
	localparam S7 = 10'b0010000000;
	localparam S8 = 10'b0100000000;
	localparam S9 = 10'b1000000000;

	// Outputs
	reg out1;
	reg out2;

	// State Transition Logic
	always @(*) begin
		case(state)
			S0:
				if(in)
					next_state = S1;
				else
					next_state = S0;
			S1:
				if(in)
					next_state = S2;
				else
					next_state = S0;
			S2:
				if(in)
					next_state = S3;
				else
					next_state = S0;
			S3:
				if(in)
					next_state = S4;
				else
					next_state = S0;
			S4:
				if(in)
					next_state = S5;
				else
					next_state = S0;
			S5:
				if(in)
					next_state = S6;
				else
					next_state = S8;
			S6:
				if(in)
					next_state = S7;
				else
					next_state = S9;
			S7:
				if(in)
					next_state = S7;
				else
					next_state = S0;
			S8:
				if(in)
					next_state = S1;
				else
					next_state = S0;
			S9:
				if(in)
					next_state = S1;
				else
					next_state = S0;
		endcase
	end

	// Output Logic
	always @(state) begin
		case(state)
			S0:
				begin
					out1 = 0;
					out2 = 0;
				end
			S7:
				begin
					out1 = 0;
					out2 = 1;
				end
			S8:
				begin
					out1 = 1;
					out2 = 0;
				end
			S9:
				begin
					out1 = 1;
					out2 = 1;
				end
			default:
				begin
					out1 = 0;
					out2 = 0;
				end
		endcase
	end
endmodule
