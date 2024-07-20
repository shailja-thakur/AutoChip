module sub_module (
    input clk,
    input L,
    input r_in,
    input q_in,
    output reg Q
);
    always @(posedge clk) begin
        if (L) begin
            Q <= r_in;
        end else begin
            Q <= q_in;
        end
    end
endmodule
module top_module (
    input clk,
    input L,
    input [2:0] r,
    output [2:0] q
);
    wire q0_in, q1_in, q2_in;
    
    // Define the inputs for each submodule instance
    assign q2_in = q[1] ^ q[2];
    assign q1_in = q[0];
    assign q0_in = q[2];

    // Instantiate three submodules
    sub_module u0 (
        .clk(clk),
        .L(L),
        .r_in(r[0]),
        .q_in(q0_in),
        .Q(q[0])
    );

    sub_module u1 (
        .clk(clk),
        .L(L),
        .r_in(r[1]),
        .q_in(q1_in),
        .Q(q[1])
    );

    sub_module u2 (
        .clk(clk),
        .L(L),
        .r_in(r[2]),
        .q_in(q2_in),
        .Q(q[2])
    );
endmodule
