module flipflop_mux(
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
module full_module (
    input [2:0] r,
    input L,
    input clk,
    output [2:0] q
);

    wire [2:0] d;
    wire [2:0] q_interim;

    // XOR operation to generate d inputs for flipflops
    assign d[2] = q_interim[1] ^ q_interim[2];
    assign d[1] = q_interim[0];
    assign d[0] = q_interim[2];

    // Instance 0
    flipflop_mux inst0 (
        .clk(clk),
        .L(L),
        .d(d[0]),
        .r(r[0]),
        .q(q_interim[0])
    );

    // Instance 1
    flipflop_mux inst1 (
        .clk(clk),
        .L(L),
        .d(d[1]),
        .r(r[1]),
        .q(q_interim[1])
    );

    // Instance 2
    flipflop_mux inst2 (
        .clk(clk),
        .L(L),
        .d(d[2]),
        .r(r[2]),
        .q(q_interim[2])
    );

    assign q = q_interim;

endmodule
