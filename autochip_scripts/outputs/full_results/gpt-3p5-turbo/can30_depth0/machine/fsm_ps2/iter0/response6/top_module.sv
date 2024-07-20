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

// Declare state variable
state_t state;

// Declare next state variable
state_t next_state;

// Declare register for input third bit
logic third_bit;

always_ff @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= BYTE1;
		third_bit <= 0;
	end
	else begin
		state <= next_state;
		third_bit <= in[2];
	end
end

always_comb begin
	case (state)
		BYTE1:
			if (third_bit)
				next_state = BYTE2;
			else
				next_state = BYTE1;
		BYTE2:
			next_state = BYTE3;
		BYTE3:
			next_state = DONE;
		DONE:
			if (third_bit)
				next_state = BYTE2;
			else
				next_state = BYTE1;
	endcase
end

assign done = (state == DONE);

endmodule
