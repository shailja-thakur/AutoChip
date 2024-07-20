module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	reg [1:0] state;
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 2'b10; // B
		end else begin
			case (state)
				2'b00: state <= in ? 2'b01 : 2'b00; // A
				2'b01: state <= in ? 2'b01 : 2'b00; // A
				2'b10: state <= in ? 2'b10 : 2'b10; // B
				default: state <= 2'b10; // B
			endcase
		end
	end

	always @(state) begin
		case (state)
			2'b00: out <= 1;
			default: out <= 0;
		endcase
	end

endmodule
