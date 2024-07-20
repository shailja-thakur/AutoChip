module top_module (
    input clk,
    input a,
    output reg [2:0] q
);

	reg [2:0] q_next;

	always @(posedge clk) begin
		case({a, q})
			2'b10: q_next <= 3'b100;
			2'b11: q_next <= 3'b100;
			2'b01: q_next <= 3'b101;
			2'b00: q_next <= 3'b110;
			default: q_next <= 3'b000;
		endcase
	end

	always @(posedge clk) begin
		q <= q_next;
	end
		
endmodule
