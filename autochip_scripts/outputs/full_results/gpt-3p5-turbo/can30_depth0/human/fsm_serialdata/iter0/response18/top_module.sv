module top_module (
	input clk,
	input in,
	input reset,
	output reg [7:0] out_byte,
	output reg done
);

// Define the states
parameter IDLE = 2'b00;
parameter START = 2'b01;
parameter DATA = 2'b10;

reg [1:0] state;
reg [1:0] next_state;

// Initialize the state
always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= IDLE;
	end else begin
		state <= next_state;
	end
end

// Define the signals
wire start_bit = ~in;
wire stop_bit = in;
wire [7:0] data = in;

// Define the next state and output logic
always @(state, start_bit, stop_bit, data) begin
	case (state)
		IDLE: begin
			if (start_bit) begin
				next_state <= START;
			end else begin
				next_state <= IDLE;
			end
		end
		
		START: begin
			if (start_bit) begin
				next_state <= DATA;
				out_byte <= data;
			end else begin
				next_state <= START;
			end
		end
		
		DATA: begin
			if (stop_bit) begin
				next_state <= IDLE;
				done <= 1;
			end else begin
				next_state <= DATA;
			end
		end
	endcase
end

endmodule
