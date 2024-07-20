module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    wire[2:0] sum_carry;
    
    assign sum_carry = a + b + cin;
    
    assign cout = (sum_carry >= 3) ? 1'b1 : 1'b0;
    assign sum = sum_carry[0];
    
endmodule
