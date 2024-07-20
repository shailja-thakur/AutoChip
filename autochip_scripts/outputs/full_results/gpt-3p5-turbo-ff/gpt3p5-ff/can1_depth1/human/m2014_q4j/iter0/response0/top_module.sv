module top_module (
    input [3:0] x,
    input [3:0] y,
    output [4:0] sum
);

    wire [3:0] intermediate_sum;
    wire carry_out;

    // Adders for bits 0 to 2
    full_adder full_adder_0(.a(x[0]), .b(y[0]), .carry_in(1'b0), .sum(intermediate_sum[0]), .carry_out(carry_out));
    full_adder full_adder_1(.a(x[1]), .b(y[1]), .carry_in(carry_out), .sum(intermediate_sum[1]), .carry_out(carry_out));
    full_adder full_adder_2(.a(x[2]), .b(y[2]), .carry_in(carry_out), .sum(intermediate_sum[2]), .carry_out(carry_out));

    // Adder for bit 3 with overflow
    full_adder full_adder_3(.a(x[3]), .b(y[3]), .carry_in(carry_out), .sum(intermediate_sum[3]), .carry_out(sum[4]));

    // Output buffer
    assign sum[3:0] = intermediate_sum;
    assign sum[0] = x[0] ^ y[0] ^ carry_out;

endmodule
module full_adder (
    input a,
    input b,
    input carry_in,
    output sum,
    output carry_out
);
    assign sum = a ^ b ^ carry_in;
    assign carry_out = (a & b) | (carry_in & (a ^ b));
endmodule
