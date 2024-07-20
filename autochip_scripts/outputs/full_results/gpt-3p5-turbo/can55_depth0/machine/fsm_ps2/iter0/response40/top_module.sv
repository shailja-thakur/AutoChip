module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

// Register for storing the current state
reg [1:0] state_reg;
// Next state
wire [1:0] state_next;

// State definition
parameter BYTE1 = 2'b00;
parameter BYTE2 = 2'b01;
parameter BYTE3 = 2'b10;
parameter DONE = 2'b11;

// Output for the third bit of the input
wire third_bit;

// Assign the third bit of the input to the wire
assign third_bit = in[2];

always @(posedge clk or posedge reset) begin
	if (reset) begin
		// Reset the state
		state_reg <= BYTE1;
	end else begin
		// Assign next state based on current state
		case (state_reg)
			BYTE1: begin
				if (third_bit) begin
					state_next <= BYTE2;
				end else begin
					state_next <= BYTE1;
				end
			end
			BYTE2: begin
				state_next <= BYTE3;
			end
			BYTE3: begin
				state_next <= DONE;
			end
			DONE: begin
				if (third_bit) begin
					state_next <= BYTE2;
				end else begin
					state_next <= BYTE1;
				end
			end
			default: state_next <= BYTE1;
		endcase
	end
end

// Update the state
always @(posedge clk or posedge reset) begin
	if (reset) begin
		state_reg <= BYTE1;
	end else begin
		state_reg <= state_next;
	end
end

// Output done signal when in the DONE state
assign done = (state_reg == DONE);

endmodule
