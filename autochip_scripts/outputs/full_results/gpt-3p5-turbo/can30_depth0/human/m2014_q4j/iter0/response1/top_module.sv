module top_module (
    input [3:0] x,
    input [3:0] y,
    output [4:0] sum
);

    	wire [3:0] a, b, c;
    	wire carry;

    	assign a = x ^ y;
    	assign b = x & y;
    	assign c[0] = 0;
    
    	generate
    		for (i=0; i<4; i=i+1) begin
    			full_adder u_full_adder(.a(a[i]), .b(b[i]), .carry(c[i]), .sum(sum[i]), .carry_out(c[i+1]));
    		end
    	endgenerate
endmodule
module full_adder (
    input a,
    input b,
    input carry,
    output sum,
    output carry_out
);
    
    assign sum = a ^ b ^ carry;
    assign carry_out = (a & b) | (carry & (a ^ b));
    
endmodule
