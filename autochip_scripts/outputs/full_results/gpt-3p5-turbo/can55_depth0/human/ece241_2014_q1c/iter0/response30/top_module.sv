module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
    reg [7:0] s;
    reg overflow;
    
    always @(a or b) begin
        s = a + b;
        if (a[7] == b[7])
            overflow = (s[7] != a[7]);
        else
            overflow = 0;
    end
    
endmodule
