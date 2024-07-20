module mux_flipflop (
    input wire D,
    input wire L,
    input wire clk,
    input wire mux_in,
    output reg q
);
    
    wire mux_out;
    
    assign mux_out = (L) ? D : mux_in;
    
    always @(posedge clk) begin
        q <= mux_out;
    end
    
endmodule
module top_module(
    input [2:0] r,
    input L,
    input clk,
    output [2:0] q
);
    
    wire q0_next, q1_next, q2_next;
    
    mux_flipflop ff0 (
        .D(r[0]),
        .L(L),
        .clk(clk),
        .mux_in(q[1] ^ q[2]),
        .q(q[0])
    );
    
    mux_flipflop ff1 (
        .D(r[1]),
        .L(L),
        .clk(clk),
        .mux_in(q[0]),
        .q(q[1])
    );
    
    mux_flipflop ff2 (
        .D(r[2]),
        .L(L),
        .clk(clk),
        .mux_in(q[2]),
        .q(q[2])
    );
    
endmodule
