module top_module (
	input in,
	input [9:0] state,
	output [9:0] next_state,
	output out1,
	output out2);

	// Declare internal wires and registers
	wire [9:0] next_state_temp;
	reg out1_temp;
	reg out2_temp;

	// Assign next_state_temp based on current state and input
	always @*
	begin
		case(state)
			10'b0000000001: next_state_temp = 10'b0000000001;
			10'b0000000010: next_state_temp = 10'b0000000110;
			10'b0000000011: next_state_temp = 10'b0000000100;
			10'b0000000100: next_state_temp = 10'b0000001000;
			10'b0000000101: next_state_temp = 10'b0000010000;
			10'b0000000110: next_state_temp = 10'b0000000011;
			10'b0000000111: next_state_temp = 10'b0000000010;
			10'b0000001000: next_state_temp = 10'b0000000100;
			10'b0000001001: next_state_temp = 10'b0000000110;
			10'b0000001010: next_state_temp = 10'b0000000001;
			default: next_state_temp = 10'b0000000000;
		endcase
	end

	// Assign outputs based on current state
	always @(state)
	begin
		case(state)
			10'b0000000111: 
				begin
					out1_temp = 1'b0;
					out2_temp = 1'b1;
				end
			10'b0000001000: 
				begin
					out1_temp = 1'b1;
					out2_temp = 1'b0;
				end
			10'b0000001010, 10'b0000001011:
				begin
					out1_temp = 1'b1;
					out2_temp = 1'b1;
				end
			default:
				begin
					out1_temp = 1'b0;
					out2_temp = 1'b0;
				end
		endcase
	end

	// Assign outputs to module ports
	assign next_state = next_state_temp;
	assign out1 = out1_temp;
	assign out2 = out2_temp;

endmodule
