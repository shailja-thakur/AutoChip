module top_module ( 
    input [15:0] a, b,
    input cin,
    output cout,
    output [15:0] sum );

    wire [3:0] a0, a1, a2, a3;
    wire [3:0] b0, b1, b2, b3;
    wire [3:0] s0, s1, s2, s3;
    wire cout0, cout1, cout2, cout3;

    bcd_fadd U0 (
        a0, b0, cin0, cout0, s0 );
    bcd_fadd U1 (
        a1, b1, cin0, cout1, s1 );
    bcd_fadd U2 (
        a2, b2, cin1, cout2, s2 );
    bcd_fadd U3 (
        a3, b3, cin2, cout3, s3 );

    assign sum = s0 + s1 + s2 + s3;
    assign cout = cout0 + cout1 + cout2 + cout3;

endmodule