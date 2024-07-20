module top_module (
    input [3:0] x,
    input [3:0] y,
    output [4:0] sum
);

    wire [3:0] carry_out;
    wire [3:0] sum_out;

    full_adder fa0(.a(x[0]), .b(y[0]), .cin(1'b0), .sum(sum_out[0]), .cout(carry_out[0]));
    full_adder fa1(.a(x[1]), .b(y[1]), .cin(carry_out[0]), .sum(sum_out[1]), .cout(carry_out[1]));
    full_adder fa2(.a(x[2]), .b(y[2]), .cin(carry_out[1]), .sum(sum_out[2]), .cout(carry_out[2]));
    full_adder fa3(.a(x[3]), .b(y[3]), .cin(carry_out[2]), .sum(sum_out[3]), .cout(carry_out[3]));
    
    assign sum_out[4] = carry_out[3];
    assign sum = {carry_out, sum_out};
    
endmodule
