module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

	// Declare internal signal for state
	reg [1:0] state;

	// Declare internal signal for output
	reg out_reg;

	// Define state encoding
	localparam OFF = 2'b00;
	localparam ON = 2'b01;

	// Sequential always block for state transitions and output
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= OFF;
		else begin
			case (state)
				OFF: begin
					if (j)
						state <= ON;
					else
						state <= OFF;
				end
				ON: begin
					if (k)
						state <= OFF;
					else
						state <= ON;
				end
			endcase
		end
	end

	// Combinational always block for output assignment
	always @* begin
		case (state)
			OFF: out_reg = 1'b0;
			ON: out_reg = 1'b1;
		endcase
	end

	// Synchronize output signal with clock
	always @(posedge clk) begin
		out <= out_reg;
	end

endmodule
