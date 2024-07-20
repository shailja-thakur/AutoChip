module mux2_1 (
    input wire a,
    input wire b,
    input wire sel,
    output wire y
);
    assign y = sel ? b : a;
endmodule
module d_flipflop (
    input wire D,
    input wire clk,
    output reg Q
);
    always @(posedge clk) begin
        Q <= D;
    end
endmodule
module top_module(
    input wire clk,
    input wire L,
    input wire [2:0] r,
    output wire [2:0] q
);

    wire [2:0] mux_out;
    wire [2:0] dff_out;

    // Instantiating 3 flip-flops and 3 multiplexers

    // Flip-flop 0
    mux2_1 mux0 (
        .a(dff_out[0]),
        .b(r[0]),
        .sel(L),
        .y(mux_out[0])
    );

    d_flipflop dff0 (
        .D(mux_out[0]),
        .clk(clk),
        .Q(dff_out[0])
    );

    // Flip-flop 1
    mux2_1 mux1 (
        .a(dff_out[1]),
        .b(r[1]),
        .sel(L),
        .y(mux_out[1])
    );

    d_flipflop dff1 (
        .D(mux_out[1]),
        .clk(clk),
        .Q(dff_out[1])
    );

    // Flip-flop 2
    mux2_1 mux2 (
        .a(dff_out[2]),
        .b(r[2]),
        .sel(L),
        .y(mux_out[2])
    );

    d_flipflop dff2 (
        .D(mux_out[2]),
        .clk(clk),
        .Q(dff_out[2])
    );

    assign q[0] = dff_out[2] ^ dff_out[1];
    assign q[1] = dff_out[0];
    assign q[2] = dff_out[2];

endmodule
