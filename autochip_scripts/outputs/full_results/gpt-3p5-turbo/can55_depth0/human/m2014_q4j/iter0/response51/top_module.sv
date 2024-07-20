module top_module (
    input [3:0] x,
    input [3:0] y,
    output [4:0] sum
);

wire [3:0] carry;
wire [3:0] sum_bits;

genvar i;

generate
    for (i = 0; i < 4; i = i + 1) begin : full_adder_block
        full_adder full (
            .a(x[i]),
            .b(y[i]),
            .cin(carry[i]),
            .sum(sum_bits[i]),
            .cout(carry[i+1])
        );
    end
endgenerate

assign sum = {carry[4], sum_bits};

endmodule
module full_adder (
    input a,
    input b,
    input cin,
    output sum,
    output cout
);
	
	assign sum = a ^ b ^ cin;
	assign cout = (a & b) | (cin & (a ^ b));
    
endmodule
