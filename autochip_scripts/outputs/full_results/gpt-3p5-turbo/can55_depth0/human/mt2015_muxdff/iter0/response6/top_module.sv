module flipflop(
	input clk,
	input D,
	output reg Q);
	
	always @(posedge clk) begin
		Q <= D;
	end
endmodule
module mux_2to1(
	input data0,
	input data1,
	input select,
	output reg out);
	
	always @(data0 or data1 or select) begin
		if (select)
			out <= data1;
		else
			out <= data0;
	end
endmodule
module top_module(
	input clk,
	input L,
	input q_in,
	input r_in,
	output reg Q);
	
	reg [2:0] q;
	
	always @(posedge clk) begin
		if (L)
			q <= r_in;
		else
			q <= {q[1] ^ q[2], q[0], q[2]};
	end
	
	flipflop ff1(.clk(clk), .D(q[2]), .Q(q_in));
	mux_2to1 mux1(.data0(q_in), .data1(r_in), .select(L), .out(Q));
endmodule
