module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

	// state enumeration
	typedef enum logic [1:0] {
		BYTE1,
		BYTE2,
		BYTE3,
		DONE
	} state_type;
	
	// state signal and next_state signal
	reg [1:0] state, next_state;
	
	// combinational logic for next_state
	always_comb begin
		case (state)
			BYTE1: next_state = (in[2] == 1) ? BYTE2 : BYTE1;
			BYTE2: next_state = BYTE3;
			BYTE3: next_state = DONE;
			DONE: next_state = (in[2] == 1) ? BYTE2 : BYTE1;
		endcase
	end
	
	// sequential logic for state
	always_ff @(posedge clk, posedge reset) begin
		if (reset) begin
			state <= BYTE1;
		end else begin
			state <= next_state;
		end
	end
	
	// done signal logic
	assign done = (state == DONE);
	
endmodule
