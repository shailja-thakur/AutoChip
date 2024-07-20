module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	reg [1:0] state;
	reg out_reg;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 2'b00; // State A
		else begin
			case (state)
				2'b00: state <= (in) ? 2'b01 : 2'b10; // State A -> State B or State A
				2'b01: state <= (in) ? 2'b01 : 2'b11; // State B -> State B or State C
				2'b10: state <= (in) ? 2'b00 : 2'b11; // State A -> State A or State D
				2'b11: state <= (in) ? 2'b01 : 2'b01; // State C -> State B or State C
				default: state <= 2'b00; // Default to State A
			endcase
		end
	end
	
	always @(posedge clk) begin
		case (state)
			2'b00: out_reg <= 1'b0; // State A, output 0
			2'b01: out_reg <= 1'b0; // State B, output 0
			2'b10: out_reg <= 1'b0; // State C, output 0
			2'b11: out_reg <= 1'b1; // State D, output 1
			default: out_reg <= 1'b0; // Default output 0
		endcase
	end
	
	assign out = out_reg;
	
endmodule
