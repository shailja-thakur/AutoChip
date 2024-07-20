module top_module (
    input clk,
    input j,
    input k,
    output reg Q
);
	reg Qold;

	always @(posedge clk) begin
		if (j & !k)
			Q <= 1;
		else if (!j & k)
			Q <= 0;
		else if (j & k)
			Q <= ~Qold;
	end
endmodule
