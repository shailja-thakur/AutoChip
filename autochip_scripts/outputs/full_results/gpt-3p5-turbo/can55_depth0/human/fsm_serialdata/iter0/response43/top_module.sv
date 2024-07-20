module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);
	// Define states
	typedef enum logic [2:0] {
		IDLE,
		START_BIT,
		DATA_BITS,
		STOP_BIT
	} state_type;
	state_type current_state, next_state;
	
	// Define internal signals
	reg [2:0] count;
	reg [7:0] received_data;
	reg done_signal;
	
	// Sequential logic for the finite state machine
	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin
			current_state <= IDLE;
			count <= 0;
			received_data <= 0;
			done_signal <= 0;
		end 
		else begin
			current_state <= next_state;
			count <= count + 1;
			received_data <= {received_data[6:0], in};
			done_signal <= 0;
		end
	end
	
	// Combinational logic for the next state and output logic
	always_comb begin
		case (current_state)
			IDLE: begin
				if (in == 1'b0) begin
					next_state = START_BIT;
					count = 0;
					received_data = 0;
				end
				else begin
					next_state = IDLE;
					count = 0;
					received_data = 0;
				end
			end
			
			START_BIT: begin
				if (count == 8) begin
					next_state = STOP_BIT;
					count = 0;
				end
				else begin
					next_state = START_BIT;
				end
			end
			
			DATA_BITS: begin
				if (count == 8) begin
					next_state = STOP_BIT;
					count = 0;
				end
				else begin
					next_state = DATA_BITS;
				end
			end
			
			STOP_BIT: begin
				if (count == 1) begin
					next_state = IDLE;
					count = 0;
					done_signal = 1;
					out_byte = received_data;
				end
				else begin
					next_state = STOP_BIT;
				end
			end
		endcase
	end
	
	// Assign outputs
	assign done = done_signal;
	
endmodule
