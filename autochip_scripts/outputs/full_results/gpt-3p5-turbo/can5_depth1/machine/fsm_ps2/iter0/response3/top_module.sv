module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

// Define states
parameter BYTE1 = 2'b00;
parameter BYTE2 = 2'b01;
parameter BYTE3 = 2'b10;
parameter DONE = 2'b11;

// Define reg and wire variables
reg [1:0] state;
wire third_bit;

// Assign third bit of input to third_bit wire
assign third_bit = in[2];

// Define state transition logic
always @(posedge clk, posedge reset) begin
	if (reset) begin
		state <= BYTE1;
	end else begin
		case (state)
			BYTE1: begin
				if (third_bit) begin
					state <= BYTE2;
				end else begin
					state <= BYTE1;
				end
			end
			BYTE2: begin
				state <= BYTE3;
			end
			BYTE3: begin
				state <= DONE;
			end
			DONE: begin
				if (third_bit) begin
					state <= BYTE2;
				end else begin
					state <= BYTE1;
				end
			end
		endcase
	end
end

// Define logic for done signal
assign done = (state == DONE);

endmodule
