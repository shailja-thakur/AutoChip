module sub_module (
    input clk,
    input L,
    input q_in,
    input r_in,
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
module top_module(
    input clk,
    input L,
    input [2:0] r,
    output [2:0] Q
);
    wire [2:0] q_intermediate;
    
    // Instantiate three submodules
    sub_module u0 (
        .clk(clk),
        .L(L),
        .q_in(q_intermediate[1] ^ q_intermediate[2]),
        .r_in(r[0]),
        .q_out(q_intermediate[0])
    );

    sub_module u1 (
        .clk(clk),
        .L(L),
        .q_in(q_intermediate[0]),
        .r_in(r[1]),
        .q_out(q_intermediate[1])
    );

    sub_module u2 (
        .clk(clk),
        .L(L),
        .q_in(q_intermediate[2]),
        .r_in(r[2]),
        .q_out(q_intermediate[2])
    );

    // Output assignments
    assign Q = q_intermediate;
endmodule
