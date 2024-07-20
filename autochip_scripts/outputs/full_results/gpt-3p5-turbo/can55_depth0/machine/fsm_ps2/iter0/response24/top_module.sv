module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

// Define states
typedef enum logic [1:0] {
	BYTE1,
	BYTE2,
	BYTE3,
	DONE
} state_t;

reg [1:0] current_state;
reg [1:0] next_state;

always_ff @(posedge clk or posedge reset) begin
	if (reset) begin
		current_state <= BYTE1;
	end else begin
		current_state <= next_state;
	end
end

always_comb begin
	case (current_state)
		BYTE1: begin
			if (in[2] == 1'b1)
				next_state = BYTE2;
			else
				next_state = BYTE1;
		end
		BYTE2: next_state = BYTE3;
		BYTE3: next_state = DONE;
		DONE: begin
			if (in[2] == 1'b1)
				next_state = BYTE2;
			else
				next_state = BYTE1;
		end
	endcase
end

assign done = (current_state == DONE);

endmodule
