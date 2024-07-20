module top_module (
    input clk,
    input L,
    input [2:0] r,
    output [2:0] q
);

    sub_module u0 (clk, L, r[0], 1'b0, q[0]);
    sub_module u1 (clk, L, r[1], q[0], q[1]);
    sub_module u2 (clk, L, r[2], q[1], q[2]);

endmodule
module sub_module (
    input clk,
    input L,
    input r_in,
    input q_in,
    output reg q_out
);

    wire mux_out;

    assign mux_out = L ? r_in : q_in;

    always @(posedge clk) begin
        q_out <= mux_out;
    end

endmodule
