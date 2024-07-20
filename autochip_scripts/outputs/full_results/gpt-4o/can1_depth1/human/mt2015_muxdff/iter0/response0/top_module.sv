module mux_ff (
    input clk,
    input L,
    input r_in,
    input q_in,
    output reg q_out
);

    always @(posedge clk) begin
        if (L) begin
            q_out <= r_in;
        end else begin
            q_out <= q_in;
        end
    end

endmodule
module full_module (
    input [2:0] r,
    input L,
    input clk,
    output [2:0] q
);

    wire q0, q1, q2;

    // Instantiate mux_ff modules
    mux_ff u0 (
        .clk(clk),
        .L(L),
        .r_in(r[0]),
        .q_in(q1 ^ q2),
        .q_out(q0)
    );

    mux_ff u1 (
        .clk(clk),
        .L(L),
        .r_in(r[1]),
        .q_in(q0),
        .q_out(q1)
    );

    mux_ff u2 (
        .clk(clk),
        .L(L),
        .r_in(r[2]),
        .q_in(q2),
        .q_out(q2)
    );

    assign q = {q2, q1, q0};

endmodule
