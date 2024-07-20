module top_module (
	input clk,
	input reset,
	input w,
	output z
);

	reg [2:0] state;
	parameter A = 3'b000;
	parameter B = 3'b001;
	parameter C = 3'b010;
	parameter D = 3'b011;
	parameter E = 3'b100;
	parameter F = 3'b101;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= A;
		else begin
			case (state)
				A: if (w) state <= B; else state <= A;
				B: if (w) state <= C; else state <= D;
				C: if (w) state <= E; else state <= D;
				D: if (w) state <= F; else state <= A;
				E: if (w) state <= E; else state <= D;
				F: if (w) state <= C; else state <= D;
				default: state <= A;
			endcase
		end
	end

	assign z = (state == E) || (state == F);
endmodule
