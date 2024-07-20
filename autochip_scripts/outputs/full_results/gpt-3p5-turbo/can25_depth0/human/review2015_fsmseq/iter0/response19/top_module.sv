module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting); // Added reg keyword for start_shifting
 
	// State enumeration
	enum {IDLE, S0, S1, S2, S3} state;
	reg [1:0] bit_buffer; // Added bit_buffer register to store last two bits
	
	always @(posedge clk) begin
		if (reset) begin
			start_shifting <= 0; // Reset start_shifting when reset is active
			state <= IDLE; // Transition to IDLE state when reset is active
			bit_buffer <= 0; // Reset bit_buffer when reset is active
		end else begin
			case (state)
				IDLE:
					if (data == 1'b1) begin
						state <= S0;
						bit_buffer <= {bit_buffer[0], data}; // Shift in current input bit
					end
				S0:
					if (data == 1'b1) begin
						state <= S1;
						bit_buffer <= {bit_buffer[0], data}; // Shift in current input bit
					end else begin
						state <= IDLE; // Return to IDLE state if input bit is 0
						bit_buffer <= {bit_buffer[0], data}; // Shift in current input bit
					end
				S1:
					if (data == 1'b1) begin
						state <= S2;
						bit_buffer <= {bit_buffer[0], data}; // Shift in current input bit
					end else begin
						state <= IDLE; // Return to IDLE state if input bit is 0
						bit_buffer <= {bit_buffer[0], data}; // Shift in current input bit
					end
				S2:
					if (data == 1'b0) begin
						state <= IDLE; // Return to IDLE state if input bit is 0
						bit_buffer <= {bit_buffer[0], data}; // Shift in current input bit
					end else if (data == 1'b1) begin
						state <= S3;
						start_shifting <= 1; // Set start_shifting to 1 when sequence is found
						bit_buffer <= {bit_buffer[0], data}; // Shift in current input bit
					end
				S3:
					if (data == 1'b1) begin
						state <= S0;
						bit_buffer <= {bit_buffer[0], data}; // Shift in current input bit
					end else begin
						state <= IDLE; // Return to IDLE state if input bit is 0
						bit_buffer <= {bit_buffer[0], data}; // Shift in current input bit
					end
			endcase
		end
	end
endmodule
