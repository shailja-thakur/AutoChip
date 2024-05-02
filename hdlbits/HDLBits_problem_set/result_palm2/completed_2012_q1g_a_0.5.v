module top_module (
    input [4:1] x,
    output f
); 

    wire [4:0] a;
    assign a[0] = x[0];
    assign a[1] = x[1];
    assign a[2] = x[2];
    assign a[3] = x[3];

    wire [4:0] b;
    assign b[0] = x[0] & x[1];
    assign b[1] = x[0] & x[2];
    assign b[2] = x[0] & x[3];
    assign b[3] = x[1] & x[2];
    assign b[4] = x[1] & x[3];
    assign b[5] = x[2] & x[3];

    wire [4:0] c;
    assign c[0] = x[0] ^ x[1];
    assign c[1] = x[0] ^ x[2];
    assign c[2] = x[0] ^ x[3];
    assign c[3] = x[1] ^ x[2];
    assign c[4] = x[1] ^ x[3];
    assign c[5] = x[2] ^ x[3];

    wire f;
    assign f = (a[0] & b[0]) | (a[0] & b[4]) | (a[1] & b[1]) | (a[1] & b[5]) | (a[2] & b[2]) | (a[2] & b[3]);

endmodule