module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

	/* Define the state enumeration */
	typedef enum logic [1:0] {
		BYTE1,
		BYTE2,
		BYTE3,
		DONE
	} state_type;
	
	/* Define the state register and initialize to BYTE1 */
	reg state_type current_state = BYTE1;
	
	/* Define the output register and initialize to 0 */
	reg [23:0] output_reg = 0;
	
	/* Define the next state and output variables */
	reg [1:0] next_state;
	reg [23:0] next_output;
	
	/* Define the transition conditions */
	always_comb begin
		case (current_state)
			BYTE1: begin
				if (in[2] == 1) next_state = BYTE2;
				else next_state = BYTE1;
				next_output = output_reg;
			end
			BYTE2: begin
				next_state = BYTE3;
				next_output = output_reg;
			end
			BYTE3: begin
				next_state = DONE;
				next_output = output_reg;
			end
			DONE: begin
				if (in[2] == 0) next_state = BYTE1;
				else next_state = DONE;
				next_output = output_reg;
			end
		endcase
	end
	
	/* Update state and output registers on rising edge of clock */
	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin
			current_state <= BYTE1;
			output_reg <= 0;
		end
		else begin
			current_state <= next_state;
			if (current_state == DONE) output_reg <= next_output;
			else output_reg <= {output_reg[15:0], in};
		end
	end
	
	/* Assign outputs */
	assign out_bytes = output_reg;
	assign done = (current_state == DONE);
	
endmodule
