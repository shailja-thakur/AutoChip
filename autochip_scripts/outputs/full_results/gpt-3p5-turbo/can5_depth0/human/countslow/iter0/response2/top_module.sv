module top_module(
	input clk,
	input slowena,
	input reset,
	output reg [3:0] q
    );
    
	reg [4:0] count;
	// synchronous reset
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			count <= 0;
		end else if (slowena) begin
			count <= count + 1;
		end
	end
	
	// assign q based on count
	always @(*) begin
		case (count)
			0: q = 4'b0000;
			1: q = 4'b0001;
			2: q = 4'b0010;
			3: q = 4'b0011;
			4: q = 4'b0100;
			5: q = 4'b0101;
			6: q = 4'b0110;
			7: q = 4'b0111;
			8: q = 4'b1000;
			9: q = 4'b1001;
		endcase
	end
endmodule
