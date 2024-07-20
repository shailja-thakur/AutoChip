module top_module (
	input clk,
	input in,
	input reset,
	output done
);

	// State declaration
	enum {IDLE, START_BIT, DATA_BITS, STOP_BIT} state;

	// Registers
	reg [7:0] data_reg;
	reg check_start, check_stop;
	reg done_reg;

	// Synchronous reset
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			data_reg <= 8'b0;
			check_start <= 1'b0;
			check_stop <= 1'b0;
			done_reg <= 1'b0;
		end else begin
			case (state)
				IDLE: state <= (in == 1'b0) ? START_BIT : IDLE;
				START_BIT: state <= DATA_BITS;
				DATA_BITS: state <= (check_stop && in) ? STOP_BIT : DATA_BITS;
				STOP_BIT: state <= IDLE;
				default: state <= IDLE;
			endcase
		end
	end

	// Data and control handling
	always @(posedge clk) begin
		case (state)
			START_BIT: begin
				data_reg <= in;
				check_start <= 1'b1;
			end
			DATA_BITS: begin
				if (check_start) begin
					data_reg <= {data_reg[6:0], in};
				end
			end
			STOP_BIT: begin
				if (check_start) begin
					check_stop <= 1'b1;
				end
			end
			IDLE: begin
				if (check_stop) begin
					done_reg <= 1'b1;
				end
			end
			default: begin
				check_start <= 1'b0;
				check_stop <= 1'b0;
				done_reg <= 1'b0;
			end
		endcase
	end

	// Done output
	assign done = done_reg;

endmodule
