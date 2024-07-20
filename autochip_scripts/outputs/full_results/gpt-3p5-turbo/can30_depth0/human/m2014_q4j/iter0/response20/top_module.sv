module top_module (
    input [3:0] x,
    input [3:0] y,
    output [4:0] sum
);
    
    wire [3:0] sum_temp;
    wire carry_out;
    
    full_adder FA0(.a(x[0]), .b(y[0]), .c_in(1'b0), .sum(sum_temp[0]), .c_out(carry_out));
    full_adder FA1(.a(x[1]), .b(y[1]), .c_in(carry_out), .sum(sum_temp[1]), .c_out(carry_out));
    full_adder FA2(.a(x[2]), .b(y[2]), .c_in(carry_out), .sum(sum_temp[2]), .c_out(carry_out));
    full_adder FA3(.a(x[3]), .b(y[3]), .c_in(carry_out), .sum(sum_temp[3]), .c_out(carry_out));
    
    assign sum = {carry_out, sum_temp};
    
endmodule
module full_adder (
    input a,
    input b,
    input c_in,
    output sum,
    output c_out
);
    
    assign sum = a ^ b ^ c_in;
    assign c_out = (a & b) | (c_in & (a ^ b));
    
endmodule
