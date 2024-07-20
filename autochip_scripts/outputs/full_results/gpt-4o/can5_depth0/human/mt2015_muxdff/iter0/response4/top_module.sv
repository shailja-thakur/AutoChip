module ff_mux(
    input CLK,
    input en,
    input D,
    input D_ff,
    output reg Q
);

    always @(posedge CLK) begin
        if (en) begin
            Q <= D;
        end else begin
            Q <= D_ff;
        end
    end
endmodule
module top_module(
    input [2:0] r,
    input L,
    input clk,
    output [2:0] q
);

    wire [2:0] D_ff;
    wire [2:0] D_mux;

    // Instantiate ff_mux submodules
    ff_mux u0 (
        .CLK(clk),
        .en(L),
        .D(r[0]),
        .D_ff({q[1] ^ q[2]}),
        .Q(D_ff[0])
    );

    ff_mux u1 (
        .CLK(clk),
        .en(L),
        .D(r[1]),
        .D_ff(q[0]),
        .Q(D_ff[1])
    );

    ff_mux u2 (
        .CLK(clk),
        .en(L),
        .D(r[2]),
        .D_ff(q[2]),
        .Q(D_ff[2])
    );

    // Output assignment
    assign q = D_ff;

endmodule
