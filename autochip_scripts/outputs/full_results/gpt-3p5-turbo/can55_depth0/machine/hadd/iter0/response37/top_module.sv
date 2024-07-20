module top_module (
	input a,
	input b,
	output sum,
	output cout
);
    reg [31:0] sum;
    reg carry;
    
    always @(a or b)
    begin
        sum <= a + b;
        carry <= a + b > 32;
    end
    
    assign sum = sum;
    assign cout = carry;
    
endmodule
