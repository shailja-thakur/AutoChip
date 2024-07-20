module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

    reg [8:0] sum;
    reg carry;

    always @(*) begin
        sum = a + b;
        carry = (sum[8] == 1);
    end

    assign s = sum[7:0];
    assign overflow = carry;

endmodule
