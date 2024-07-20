module top_module (
	  input [1023:0] in,
	  input [7:0] sel,
	  output [3:0] out
	);
	reg [255:0] in_reg [0:3];
	assign out = in_reg[sel];
	
	always @(in or sel)
	begin
		for (int i=0; i<4; i=i+1)
		begin
			in_reg[i] = in[(i+1)*256-1:i*256];
		end
	end
	
endmodule
