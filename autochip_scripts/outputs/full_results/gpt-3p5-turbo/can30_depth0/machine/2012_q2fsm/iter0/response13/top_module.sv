module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);
	reg [2:0] state;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 3'b000;
		else if (w)
			case (state)
				3'b000: state <= 3'b001;
				3'b001: state <= 3'b010;
				3'b010: state <= 3'b100;
				3'b011: state <= 3'b111;
				3'b100: state <= 3'b100;
				3'b101: state <= 3'b010;
				default: state <= 3'b011;
			endcase
		else
			case (state)
				3'b000: state <= 3'b000;
				3'b001: state <= 3'b011;
				3'b010: state <= 3'b011;
				3'b011: state <= 3'b000;
				3'b100: state <= 3'b011;
				3'b101: state <= 3'b101;
				default: state <= 3'b110;
			endcase
		end
	end

	assign z = (state == 3'b100) || (state == 3'b110);

endmodule
