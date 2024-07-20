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
    input [2:0] r,
    input L,
    output [2:0] q
);

    wire q_0_d, q_1_d, q_2_d;
    wire q_0_out, q_1_out, q_2_out;

    assign q_0_d = q_1_out ^ q_2_out;
    assign q_1_d = q_0_out;
    assign q_2_d = q_2_out;

    flipflop_mux mux0 (.clk(clk), .L(L), .d(q_0_d), .r(r[0]), .q(q_0_out));
    flipflop_mux mux1 (.clk(clk), .L(L), .d(q_1_d), .r(r[1]), .q(q_1_out));
    flipflop_mux mux2 (.clk(clk), .L(L), .d(q_2_d), .r(r[2]), .q(q_2_out));

    assign q = {q_2_out, q_1_out, q_0_out};

endmodule
