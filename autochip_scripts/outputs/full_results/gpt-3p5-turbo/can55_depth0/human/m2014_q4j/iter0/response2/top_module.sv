module top_module (
    input [3:0] x,
    input [3:0] y,
    output [4:0] sum
);

wire [3:0] carry; // carry signals between full adders

// instantiate the full adders
full_adder fa0(.a(x[0]), .b(y[0]), .cin(1'b0), .sum(sum[0]), .cout(carry[0]));
full_adder fa1(.a(x[1]), .b(y[1]), .cin(carry[0]), .sum(sum[1]), .cout(carry[1]));
full_adder fa2(.a(x[2]), .b(y[2]), .cin(carry[1]), .sum(sum[2]), .cout(carry[2]));
full_adder fa3(.a(x[3]), .b(y[3]), .cin(carry[2]), .sum(sum[3]), .cout(carry[3]));

// connect overflow bit to carry out of the last full adder
assign sum[4] = carry[3];

endmodule
module full_adder (
    input a,
    input b,
    input cin,
    output sum,
    output cout
);
    wire w1, w2, w3;

    // XOR gate to compute the sum
    assign sum = a ^ b;

    // AND gates to compute the carry out and carry in
    assign w1 = a & b;
    assign w2 = a & cin;
    assign w3 = b & cin;
    assign cout = w1 | w2 | w3;

endmodule
