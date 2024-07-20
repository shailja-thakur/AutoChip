module flipflop_mux (
    input wire D,
    input wire clk,
    input wire sel,
    input wire mux_in,
    output reg Q
);

    always @(posedge clk) begin
        if (sel) begin
            Q <= mux_in;
        end else begin
            Q <= D;
        end
    end
endmodule
module top_module (
    input wire clk,
    input wire L,
    input wire [2:0] r,
    output wire [2:0] q
);

    wire [2:0] q_internal;

    flipflop_mux u0 (
        .D(q_internal[1] ^ q_internal[2]),
        .clk(clk),
        .sel(L),
        .mux_in(r[0]),
        .Q(q_internal[0])
    );

    flipflop_mux u1 (
        .D(q_internal[0]),
        .clk(clk),
        .sel(L),
        .mux_in(r[1]),
        .Q(q_internal[1])
    );

    flipflop_mux u2 (
        .D(q_internal[2]),
        .clk(clk),
        .sel(L),
        .mux_in(r[2]),
        .Q(q_internal[2])
    );

    assign q = q_internal;

endmodule
