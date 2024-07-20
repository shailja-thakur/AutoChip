module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

// Add an internal state register
reg [1:0] state;
reg [23:0] temp_bytes;

// Define the states
parameter IDLE = 2'b00;
parameter SEARCHING = 2'b01;
parameter RECEIVING = 2'b10;

// Assign initial values to registers
initial begin
	state = IDLE;
	temp_bytes = 24'b0;
	out_bytes = 24'b0;
	done = 0;
end

// Always block to handle the state transition and output generation
always @(posedge clk, posedge reset) begin
	if (reset) begin
		state <= IDLE;
		temp_bytes <= 24'b0;
		out_bytes <= 24'b0;
		done <= 0;
	end else begin
		case (state)
			IDLE: begin
				if (in[3] == 1'b1) begin
					state <= SEARCHING;
				end else begin
					state <= IDLE;
				end
			end
			SEARCHING: begin
				if (in[3] == 1'b1) begin
					state <= RECEIVING;
					temp_bytes[23:16] <= in;
				end else begin
					state <= SEARCHING;
				end
			end
			RECEIVING: begin
				if (in[3] == 1'b1) begin
					state <= RECEIVING;
				end else begin
					state <= IDLE;
					temp_bytes[15:8] <= in;
				end
				if (out_bytes[7:0] != 8'b0) begin
					out_bytes[23:0] <= temp_bytes[23:0];
					done <= 1;
				end
			end
		endcase
	end
end

endmodule
