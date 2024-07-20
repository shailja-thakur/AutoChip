module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

	reg [2:0] state;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 3'b001;
		else begin
			case (state)
				3'b001: if (x) state <= 3'b010; else state <= 3'b001;
				3'b010: if (x) state <= 3'b101; else state <= 3'b010;
				3'b011: if (x) state <= 3'b010; else state <= 3'b011;
				3'b100: if (x) state <= 3'b011; else state <= 3'b100;
				3'b101: if (x) state <= 3'b111; else state <= 3'b101;
				3'b110: if (x) state <= 3'b010; else state <= 3'b110;
				3'b111: if (x) state <= 3'b100; else state <= 3'b111;
			endcase
		end
	end

	always @(state) begin
		if (state == 3'b100 || state == 3'b101 || state == 3'b110 || state == 3'b111)
			z <= 1'b1;
		else
			z <= 1'b0;
	end

endmodule
