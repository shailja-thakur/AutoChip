module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

// State encoding
typedef enum reg [1:0] {
	BYTE1 = 2'b00,
	BYTE2 = 2'b01,
	BYTE3 = 2'b10,
	DONE  = 2'b11
} state_t;

// State registers
reg [1:0] current_state, next_state;

// Data register
reg [23:0] data_reg;

// Sequential logic for state transitions and output updates
always @(posedge clk or posedge reset) begin
	if (reset) begin
		current_state <= BYTE1;
		data_reg <= 24'b0;
		out_bytes <= 24'b0;
		done <= 1'b0;
	end else begin
		current_state <= next_state;
		if (current_state != DONE) begin
			data_reg <= {data_reg[15:0], in};
		end
		if (current_state == DONE) begin
			out_bytes <= data_reg;
		end
	end
end

// Combinational logic for next state logic
always @(*) begin
	// Default assignments
	next_state = current_state;
	done = 1'b0;

	case (current_state)
		BYTE1: begin
			if (in[2]) begin
				next_state = BYTE2;
			end else begin
				next_state = BYTE1;
			end
		end
		BYTE2: begin
			next_state = BYTE3;
		end
		BYTE3: begin
			next_state = DONE;
		end
		DONE: begin
			done = 1;
			if (in[2] == 0) begin
				next_state = BYTE1;
			end
		end
	endcase
end

endmodule
