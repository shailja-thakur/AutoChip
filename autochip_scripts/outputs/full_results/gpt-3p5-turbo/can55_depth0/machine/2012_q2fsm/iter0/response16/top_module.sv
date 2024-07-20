module top_module (
	input clk,
	input reset,
	input w,
	output z
);
	reg [2:0] state;
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 0;
		else if (w==1'b0)
			case(state)
				3'b000: state <= 3'b000;
				3'b001: state <= 3'b100;
				3'b010: state <= 3'b100;
				3'b011: state <= 3'b000;
				3'b100: state <= 3'b100;
				3'b101: state <= 3'b100;
				default: state <= 3'b000;
			endcase
		else if (w==1'b1)
			case(state)
				3'b000: state <= 3'b001;
				3'b001: state <= 3'b010;
				3'b010: state <= 3'b101;
				3'b011: state <= 3'b111;
				3'b100: state <= 3'b100;
				3'b101: state <= 3'b101;
				default: state <= 3'b000;
			endcase
		end
	end
	assign z = (state == 3'b101) | (state == 3'b110);
		
endmodule
