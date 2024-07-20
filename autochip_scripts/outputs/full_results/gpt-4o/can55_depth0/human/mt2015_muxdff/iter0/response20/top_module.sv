module flipflop_mux(
    input clk,
    input L,
    input d_mux,
    input r,
    output reg q
);
    always @(posedge clk) begin
        if (L)
            q <= r;
        else
            q <= d_mux;
    end
endmodule
module top_module(
    input clk,
    input L,
    input [2:0] r_in,
    output [2:0] q
);
    wire [2:0] d_mux;
    
    assign d_mux[0] = q[1] ^ q[2];
    assign d_mux[1] = q[0];
    assign d_mux[2] = q[2];
    
    flipflop_mux inst0(
        .clk(clk),
        .L(L),
        .d_mux(d_mux[0]),
        .r(r_in[0]),
        .q(q[0])
    );

    flipflop_mux inst1(
        .clk(clk),
        .L(L),
        .d_mux(d_mux[1]),
        .r(r_in[1]),
        .q(q[1])
    );

    flipflop_mux inst2(
        .clk(clk),
        .L(L),
        .d_mux(d_mux[2]),
        .r(r_in[2]),
        .q(q[2])
    );
endmodule
