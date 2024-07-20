module top_module (
	input clk,
	input reset,
	input w,
	output z
);

	reg [2:0] state;
	parameter A=3'b000, B=3'b001, C=3'b010, D=3'b011, E=3'b100, F=3'b101;
	assign z = (state == E) || (state == F);
	
	always @(posedge clk or posedge reset) begin
		if(reset)
			state <= A;
		else begin
			case({w, state})
				2'b00: state <= A;
				2'b01: state <= B;
				2'b10: state <= C;
				2'b11: state <= D;
				3'b100: state <= E;
				3'b101: state <= F;
				default: state <= A;
			endcase
		end
	end
endmodule
