module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

wire [3:0] carry;
wire [4:0] sum_temp;
wire overflow;

// Full Adder
for (i=0; i<4; i=i+1) begin
    FA_full_adder full_adder (
        .a(x[i]),
        .b(y[i]),
        .cin(carry[i]),
        .sum(sum_temp[i]),
        .cout(carry[i+1])
    );
end

// Connection for last carry out
assign carry[4] = carry[3];

// Output sum
assign sum[4] = overflow;
assign sum[3:0] = sum_temp[3:0];

endmodule
module FA_full_adder (
    input a, b, cin,
    output sum, cout
);

assign sum = (a ^ b) ^ cin;
assign cout = (a & b) | (cin & (a ^ b));

endmodule
