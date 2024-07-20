module top_module (
	input [2:0] a, 
	output reg [15:0] q
);
	always @(*) begin
		case(a)
			3'b000: q = 16'h1232; // 15ns
			3'b001: q = 16'haee0; // 20ns, 60ns, 75ns, 80ns
			3'b010: q = 16'h27d4; // 25ns, 65ns
			3'b011: q = 16'h5a0e; // 30ns, 85ns
			3'b100: q = 16'h2066; // 35ns, 70ns
			3'b101: q = 16'h64ce; // 40ns, 90ns
			3'b110: q = 16'hc526; // 45ns
			3'b111: q = 16'h2f19; // 50ns
			default: q = 16'h0000;
		endcase
	end
endmodule
