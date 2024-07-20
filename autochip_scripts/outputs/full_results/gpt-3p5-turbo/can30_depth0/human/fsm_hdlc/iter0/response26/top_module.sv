module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);

	// Define states
	typedef enum logic [2:0] {
		IDLE,
		DISC,
		FLAG,
		ERR
	} state_t;
	
	// Define state register
	reg state_t current_state;
	
	// Define output registers
	reg disc_reg;
	reg flag_reg;
	reg err_reg;
	
	// Define next state and output logic
	always_ff @(posedge clk, posedge reset) begin
		if (reset) begin
			current_state <= IDLE;
			disc_reg <= 0;
			flag_reg <= 0;
			err_reg <= 0;
		end else begin
			case (current_state)
				IDLE:
					if (in) begin
						current_state <= DISC;
						disc_reg <= 1;
					end else if (in) begin
						current_state <= IDLE;
						disc_reg <= 0;
					end
				DISC:
					if (!in) begin
						current_state <= FLAG;
						flag_reg <= 1;
					end else if in begin
						current_state <= IDLE;
						disc_reg <= 0;
					end
				FLAG:
					if (!in) begin
						current_state <= FLAG;
						flag_reg <= 1;
					end else if (in) begin
						current_state <= FLAG;
						flag_reg <= 0;
					end
				ERR:
					if (!in) begin
						current_state <= IDLE;
						err_reg <= 0;
					end
			endcase
		end
	end
	
	// Assign output signals
	assign disc = disc_reg;
	assign flag = flag_reg;
	assign err = err_reg;
endmodule
