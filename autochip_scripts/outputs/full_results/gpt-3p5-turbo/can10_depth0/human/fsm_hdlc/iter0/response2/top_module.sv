module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);

	// Define states
	typedef enum logic [2:0] {
		S0,
		S1,
		S2
	} state_t;

	// Define internal signals
	reg [2:0] state;
	reg disc_internal;
	reg flag_internal;
	reg err_internal;

	// Output assignments
	assign disc = disc_internal;
	assign flag = flag_internal;
	assign err = err_internal;

	// Next state and output logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= S0;
			disc_internal <= 1'b0;
			flag_internal <= 1'b0;
			err_internal <= 1'b0;
		end else begin
			case (state)
				S0: begin
					if (in) begin
						state <= S1;
					end else begin
						state <= S0;
					end
				end
				S1: begin
					if (in) begin
						state <= S2;
					end else begin
						state <= S0;
					end
				end
				S2: begin
					if (in) begin
						state <= S2;
						err_internal <= 1'b1;
					end else begin
						state <= S0;
						disc_internal <= 1'b1;
					end
				end
				default: begin
					state <= S0;
				end
			endcase
		end
	end
endmodule
