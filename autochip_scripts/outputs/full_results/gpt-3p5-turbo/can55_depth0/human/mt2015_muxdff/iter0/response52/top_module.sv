module flipflop(
    input clk,
    input D,
    output reg Q
);

    always @(posedge clk) begin
        Q <= D;
    end

endmodule
module mux_2to1(
    input S,
    input D0,
    input D1,
    output reg Y
);

    always @(*) begin
        if (S == 0) begin
            Y <= D0;
        end else begin
            Y <= D1;
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

    wire mux_out1, mux_out2, ff_out;

    flipflop ff1(clk, mux_out1, ff_out);
    mux_2to1 mux1(L, q_in, r_in, mux_out1);
    mux_2to1 mux2(L, ff_out, mux_out2, Q);
    mux_2to1 mux3(L, mux_out2, r_in, mux_out1);

endmodule
module full_module (
    input [2:0] r,
    input L,
    input clk,
    output reg [2:0] q
);

    top_module inst(clk, L, q, r, q);

    always @(posedge clk) begin
        if (L) begin
            q <= r;
        end else begin
            q <= {q[1] ^ q[2], q[0], q[2]};
        end
    end

endmodule
