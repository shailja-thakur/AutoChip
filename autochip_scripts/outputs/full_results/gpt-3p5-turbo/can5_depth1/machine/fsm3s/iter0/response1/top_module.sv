module top_module (
    input clk,
    input in,
    input reset,
    output out
);

	reg [1:0] state;
	reg out_reg;

	// Initialize state to A
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 2'b00; // A
		end else begin
			case(state)
				2'b00: if (in) state <= 2'b01; else state <= 2'b00; // A to B
				2'b01: if (in) state <= 2'b01; else state <= 2'b10; // B to C
				2'b10: if (in) state <= 2'b11; else state <= 2'b00; // C to D
				2'b11: if (in) state <= 2'b01; else state <= 2'b10; // D to C
				default: state <= 2'b00;
			endcase
		end
	end

	// Update output based on state
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			out_reg <= 1'b0;
		end else begin
			if (state == 2'b10) begin // D
				out_reg <= 1'b1;
			end else begin
				out_reg <= 1'b0;
			end
		end
	end

	assign out = out_reg;

endmodule
