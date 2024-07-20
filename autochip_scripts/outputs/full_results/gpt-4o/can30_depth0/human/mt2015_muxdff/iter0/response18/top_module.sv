module mux2_1 (
    input wire a, 
    input wire b, 
    input wire sel, 
    output reg y
);
    always @(*) begin
        if (sel) 
            y = b;
        else 
            y = a;
    end
endmodule
module d_ff (
    input wire clk,
    input wire d,
    output reg q
);
    always @(posedge clk) begin
        q <= d;
    end
endmodule
module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output Q
);
    wire d;
    
    mux2_1 u_mux (
        .a(q_in),
        .b(r_in),
        .sel(L),
        .y(d)
    );

    d_ff u_ff (
        .clk(clk),
        .d(d),
        .q(Q)
    );
endmodule
module full_module (
    input [2:0] r,
    input L,
    input clk,
    output [2:0] q
);
    wire [2:0] q_internal;
    
    top_module u0 (
        .clk(clk),
        .L(L),
        .q_in(q_internal[1] ^ q_internal[2]),
        .r_in(r[0]),
        .Q(q[0])
    );

    top_module u1 (
        .clk(clk),
        .L(L),
        .q_in(q_internal[0]),
        .r_in(r[1]),
        .Q(q[1])
    );

    top_module u2 (
        .clk(clk),
        .L(L),
        .q_in(q_internal[2]),
        .r_in(r[2]),
        .Q(q[2])
    );
endmodule
