module top_module (
    input [4:0] a,
    input [4:0] b,
    input [4:0] c,
    input [4:0] d,
    input [4:0] e,
    input [4:0] f,
    output [7:0] w,
    output [7:0] x,
    output [7:0] y,
    output [7:0] z
);
    wire [1:0] last_bit;
    assign last_bit = 2'b11;
    
    assign w = {a[3:0], last_bit[1]};
    assign x = {b[3:0], last_bit[0]};
    assign y = {c[3:0], last_bit[1]};
    assign z = {d[3:0], last_bit[0]};
    
    assign w[7:2] = e[4:0];
    assign x[7:2] = f[4:0];
endmodule
