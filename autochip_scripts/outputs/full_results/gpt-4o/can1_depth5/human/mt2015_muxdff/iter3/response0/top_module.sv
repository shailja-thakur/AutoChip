module ff_mux(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg q_out
);

// Always block triggered by the rising edge of the clock
always @(posedge clk) begin
    if (L) begin
        q_out <= r_in;  // Load r_in into q_out when L is high
    end else begin
        q_out <= q_in;  // Load q_in into q_out when L is low
    end
end

endmodule
module full_module(
    input [2:0] r,
    input L,
    input clk,
    output [2:0] q
);

// Internal signals for submodules' outputs
wire q0, q1, q2;

// Instantiate the first FF_MUX submodule
ff_mux u1 (
    .clk(clk),
    .L(L),
    .q_in(q[1] ^ q[2]),  // XOR of q[1] and q[2]
    .r_in(r[0]),
    .q_out(q0)
);

// Instantiate the second FF_MUX submodule
ff_mux u2 (
    .clk(clk),
    .L(L),
    .q_in(q0),  // Chained from the first output
    .r_in(r[1]),
    .q_out(q1)
);

// Instantiate the third FF_MUX submodule
ff_mux u3 (
    .clk(clk),
    .L(L),
    .q_in(q2),  // Chained from the third output
    .r_in(r[2]),
    .q_out(q2)
);

// Assign the outputs of submodules to q
assign q = {q2, q1, q0};

endmodule
module top_module(
    input clk,
    input L,
    input [2:0] r,
    output [2:0] q
);

// Instantiate the full_module
full_module u_full (
    .clk(clk),
    .L(L),
    .r(r),
    .q(q)
);

endmodule
