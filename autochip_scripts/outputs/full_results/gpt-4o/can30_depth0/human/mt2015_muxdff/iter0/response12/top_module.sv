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
            // q <= MUX_out;
            q <= d;
        end
    end
endmodule
module top_module(
    input clk,
    input L,
    input [2:0] r,
    output [2:0] Q
);
    wire d0, d1, d2;
    wire q0, q1, q2;

    // Connect input wires for the original right bit shifts
    assign d0 = q1 ^ q2;
    assign d1 = q0;
    assign d2 = q2;

    flipflop_mux ffm0 (
        .clk(clk),
        .L(L),
        .d(d0),
        .r(r[0]),
        .q(q0)
    );

    flipflop_mux ffm1 (
        .clk(clk),
        .L(L),
        .d(d1),
        .r(r[1]),
        .q(q1)
    );

    flipflop_mux ffm2 (
        .clk(clk),
        .L(L),
        .d(d2),
        .r(r[2]),
        .q(q2)
    );
    
    // Outputs
    assign Q = {q2, q1, q0};
endmodule
