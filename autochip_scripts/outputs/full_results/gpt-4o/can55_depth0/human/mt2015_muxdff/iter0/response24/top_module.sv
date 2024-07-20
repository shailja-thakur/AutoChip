module mux_ff (
    input wire clk,
    input wire L,
    input wire D_mux0,
    input wire D_mux1,
    output reg Q
);
    always @(posedge clk) begin
        if (L) begin
            Q <= D_mux1;
        end else begin
            Q <= D_mux0;
        end
    end
endmodule
module top_module(
    input wire clk,
    input wire L,
    input wire [2:0] r,
    output wire [2:0] q
);
    // Instantiate the submodules
    mux_ff u0 (
        .clk(clk),
        .L(L),
        .D_mux0(q[1] ^ q[2]),
        .D_mux1(r[0]),
        .Q(q[0])
    );
    mux_ff u1 (
        .clk(clk),
        .L(L),
        .D_mux0(q[0]),
        .D_mux1(r[1]),
        .Q(q[1])
    );
    mux_ff u2 (
        .clk(clk),
        .L(L),
        .D_mux0(q[2]),
        .D_mux1(r[2]),
        .Q(q[2])
    );
endmodule
