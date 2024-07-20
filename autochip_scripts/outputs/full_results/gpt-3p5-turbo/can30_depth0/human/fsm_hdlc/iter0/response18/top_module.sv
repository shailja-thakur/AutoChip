module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);

	reg [2:0] state;
	reg disc_out;
	reg flag_out;
	reg err_out;

	// States
	parameter IDLE = 0;
	parameter FOUND_DISC = 1;
	parameter FOUND_FLAG = 2;
	parameter FOUND_ERR = 3;

	// Next state and output logic
	always @(posedge clk) begin
		if (reset) begin
			state <= IDLE;
			disc_out <= 0;
			flag_out <= 0;
			err_out <= 0;
		end else begin
			case (state)
				IDLE: begin
					if (in) begin
						state <= FOUND_DISC;
						disc_out <= 1;
						flag_out <= 0;
						err_out <= 0;
					end else begin
						state <= IDLE;
						disc_out <= 0;
						flag_out <= 0;
						err_out <= 0;
					end
				end
				FOUND_DISC: begin
					if (in) begin
						state <= FOUND_ERR;
						disc_out <= 0;
						flag_out <= 0;
						err_out <= 1;
					end else begin
						state <= FOUND_FLAG;
						disc_out <= 0;
						flag_out <= 1;
						err_out <= 0;
					end
				end
				FOUND_FLAG: begin
					if (in) begin
						state <= FOUND_ERR;
						disc_out <= 0;
						flag_out <= 0;
						err_out <= 1;
					end else begin
						state <= FOUND_DISC;
						disc_out <= 1;
						flag_out <= 0;
						err_out <= 0;
					end
				end
				FOUND_ERR: begin
					if (in) begin
						state <= FOUND_ERR;
						disc_out <= 0;
						flag_out <= 0;
						err_out <= 1;
					end else begin
						state <= IDLE;
						disc_out <= 0;
						flag_out <= 0;
						err_out <= 0;
					end
				end
			endcase
		end
	end

	// Assign the outputs
	assign disc = disc_out;
	assign flag = flag_out;
	assign err = err_out;

endmodule
