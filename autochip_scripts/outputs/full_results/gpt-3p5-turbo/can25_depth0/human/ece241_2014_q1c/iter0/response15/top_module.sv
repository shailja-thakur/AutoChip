module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);
    
    wire carry_out;
    wire sign_a;
    wire sign_b;
    wire sign_s;
    
    assign sign_a = a[7];
    assign sign_b = b[7];
    assign sign_s = s[7];
    
    assign carry_out = (a[7] & b[7]) | (a[7] & ~s[7]) | (b[7] & ~s[7]);
    
    assign s = a + b;
    
    assign overflow = (sign_a & sign_b & ~sign_s) | (~sign_a & ~sign_b & sign_s);
    

endmodule
