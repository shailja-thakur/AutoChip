module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

typedef enum reg [1:0] {
	S0 = 2'b00,   // Initial state, looking for the first byte
	S1 = 2'b01,   // First byte received
	S2 = 2'b10,   // Second byte received
	S3 = 2'b11    // Third byte received
} state_t;

state_t current_state, next_state;
reg [7:0] byte1, byte2, byte3;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		current_state <= S0;
		out_bytes <= 24'bx;
		done <= 1'b0;
		byte1 <= 8'b0;
		byte2 <= 8'b0;
		byte3 <= 8'b0;
	else
		current_state <= next_state;
		if(done == 1'b1) 
			out_bytes <= {byte1, byte2, byte3};
end

always @(*) begin
	next_state = current_state;
	done = 1'b0;
	case (current_state)
		S0: begin
			if (in[3] == 1'b1)
				next_state = S1;
		end
		S1: begin
			byte1 = in;
			next_state = S2;
		end
		S2: begin
			byte2 = in;
			next_state = S3;
		end
		S3: begin
			byte3 = in;
			next_state = S0;
			done = 1'b1;
		end
	endcase
end

endmodule
