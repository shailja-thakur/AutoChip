module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
    reg signed [8:0] sum;
    
    always @(*) begin
        sum = a + b;
        s = sum[7:0];
        
        // Check for signed overflow
        if ((a[7] == b[7]) && (s[7] != a[7])) begin
            overflow = 1;
        end else begin
            overflow = 0;
        end
    end
endmodule
