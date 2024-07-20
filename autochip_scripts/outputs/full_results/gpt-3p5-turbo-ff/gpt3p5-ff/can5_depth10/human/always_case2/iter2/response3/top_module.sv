module top_module (
	input [3:0] in,
	output reg [1:0] pos
);

	always @(*)
	begin
		case(in)
			4'b0001: pos = 2'b00;
			4'b0010: pos = 2'b01;
			4'b0100: pos = 2'b10;
			4'b1000: pos = 2'b11;
			default: pos = 2'b00;
		endcase
	end

	initial
	begin
		$dumpfile("wave.vcd");
		$dumpvars(0, top_module);
		$display("Start simulation");
		#10;
		$display("in=0000, pos=%b", pos);
		in <= 4'b0000;
		#10;
		$display("in=0001, pos=%b", pos);
		in <= 4'b0001;
		#10;
		$display("in=0010, pos=%b", pos);
		in <= 4'b0010;
		#10;
		$display("in=0100, pos=%b", pos);
		in <= 4'b0100;
		#10;
		$display("in=1000, pos=%b", pos);
		in <= 4'b1000;
		#10;
		$display("in=0110, pos=%b", pos);
		in <= 4'b0110;
		#10;
		$display("in=0000, pos=%b", pos);
		in <= 4'b0000;
		#10;
		$display("in=1010, pos=%b", pos);
		in <= 4'b1010;
		#10;
		$display("in=1100, pos=%b", pos);
		in <= 4'b1100;
		#10;
		$display("in=1111, pos=%b", pos);
		in <= 4'b1111;
		#10;
		$finish;
	end
endmodule
