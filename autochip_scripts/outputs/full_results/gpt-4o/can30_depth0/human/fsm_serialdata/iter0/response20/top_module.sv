module top_module (
	input clk,
	input in,
	input reset,
	output reg [7:0] out_byte,
	output reg done
);

	// State encoding
	parameter IDLE = 3'b000, 
	          START = 3'b001, 
	          DATA = 3'b010, 
	          STOP = 3'b011;
	              
	reg [2:0] state, next_state;
	reg [2:0] bit_count;
	reg [7:0] data_byte;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			bit_count <= 3'b000;
			data_byte <= 8'b0;
			out_byte <= 8'b0;
			done <= 0;
		end else begin
			state <= next_state;
		end
	end

	always @(posedge clk) begin
		case (state)
			IDLE: begin
				done <= 0;
				if (in == 0) // Detect start bit
					next_state <= START;
				else
					next_state <= IDLE;
			end
			
			START: begin
				if (in == 0) // Confirm start bit is still 0
					next_state <= DATA;
				else
					next_state <= IDLE; // False start bit
			end
			
			DATA: begin
				if (bit_count < 8) begin
					data_byte[bit_count] <= in;
					bit_count <= bit_count + 1;
					next_state <= DATA;
				end else begin
					bit_count <= 3'b000; // Reset bit counter
					next_state <= STOP;
				end
			end
			
			STOP: begin
				if (in == 1) begin
					out_byte <= data_byte;
					done <= 1;
					next_state <= IDLE;
				end else begin
					next_state <= IDLE; // Incorrect stop bit, reset FSM
				end
			end
			
			default: next_state <= IDLE;
		endcase
	end
endmodule
