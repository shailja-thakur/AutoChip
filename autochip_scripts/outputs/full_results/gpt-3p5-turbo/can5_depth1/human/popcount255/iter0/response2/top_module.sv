module top_module (
	input [254:0] in,
	output reg [7:0] out
);

	always @(*)
	begin
		reg [7:0] count;
		reg [254:0] temp;
		
		temp = in;
		count = 0;
		
		for (integer i = 0; i < 255; i = i + 1)
		begin
			if (temp[i] == 1'b1)
				count = count + 1;
		end
		
		out = count;
	end
	
endmodule
