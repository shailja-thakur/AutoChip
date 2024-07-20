module flipflop_mux (
    input clk,
    input L,
    input d,
    input r,
    output reg q
);
    always @(posedge clk) begin
        if (L) begin
            q <= r;
        end else begin
            q <= d;
        end
    end
endmodule
module top_module(
    input clk,
    input L,
    input [2:0] r,
    output [2:0] q
);
    wire q1, q2, q3;
    
    flipflop_mux ffm0 (
        .clk(clk),
        .L(L),
        .d(q2 ^ q1),
        .r(r[0]),
        .q(q[0])
    );
    
    flipflop_mux ffm1 (
        .clk(clk),
        .L(L),
        .d(q3),
        .r(r[1]),
        .q(q[1])
    );
    
    flipflop_mux ffm2 (
        .clk(clk),
        .L(L),
        .d(q[0]),
        .r(r[2]),
        .q(q[2])
    );
endmodule
