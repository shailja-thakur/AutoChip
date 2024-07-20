module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

	// Define states
	parameter OFF = 0;
	parameter ON = 1;

	// Define signals
	reg [1:0] state;
	reg out_reg;

	// State register
	always @(posedge clk, posedge reset) begin
		if (reset) begin
			state <= OFF;
		end else begin
			case (state)
				OFF: begin
					if (j) begin
						state <= ON;
					end else begin
						state <= OFF;
					end
				end
				ON: begin
					if (k) begin
						state <= OFF;
					end else begin
						state <= ON;
					end
				end
				default: state <= OFF;
			endcase
		end
	end

	// Output register
	always @(posedge clk) begin
		case (state)
			OFF: out_reg <= 0;
			ON: out_reg <= 1;
			default: out_reg <= 0;
		endcase
	end

	// Output
	assign out = out_reg;

endmodule
