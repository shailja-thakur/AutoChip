module flipflop_mux(
    input clk,
    input L,
    input r,
    input q,
    output reg Q
);

    always @(posedge clk) begin
        if (L) begin
            Q <= r;
        end else begin
            Q <= (q[1] ^ q[2]);
        end
    end
    
endmodule
module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);

    wire [2:0] q;
    
    flipflop_mux u1 (
        .clk(clk),
        .L(L),
        .r(r_in),
        .q(q[0]),
        .Q(q_in[0])
    );
    
    flipflop_mux u2 (
        .clk(clk),
        .L(L),
        .r(r_in),
        .q(q[1]),
        .Q(q_in[1])
    );
    
    flipflop_mux u3 (
        .clk(clk),
        .L(L),
        .r(r_in),
        .q(q[2]),
        .Q(q_in[2])
    );
    
    assign Q = q[0] & q[1] | q[2];
    
endmodule
