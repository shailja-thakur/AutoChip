module top_module (
    input [3:0] x,
    input [3:0] y,
    output [4:0] sum
);
    wire [3:0] carry;
    wire overflow;
    wire [3:0] sum_internal;
    
    // Instantiating full adders for each bit
    full_adder adder0 (.a(x[0]), .b(y[0]), .cin(1'b0), .sum(sum_internal[0]), .cout(carry[0]));
    full_adder adder1 (.a(x[1]), .b(y[1]), .cin(carry[0]), .sum(sum_internal[1]), .cout(carry[1]));
    full_adder adder2 (.a(x[2]), .b(y[2]), .cin(carry[1]), .sum(sum_internal[2]), .cout(carry[2]));
    full_adder adder3 (.a(x[3]), .b(y[3]), .cin(carry[2]), .sum(sum_internal[3]), .cout(carry[3]));

    // Overflow calculation
    assign overflow = carry[3] ^ carry[2];

    // Final sum output with overflow bit
    assign sum = {overflow, sum_internal};

endmodule
module full_adder (
    input a,
    input b,
    input cin,
    output sum,
    output cout
);
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (a & cin) | (b & cin);
endmodule
