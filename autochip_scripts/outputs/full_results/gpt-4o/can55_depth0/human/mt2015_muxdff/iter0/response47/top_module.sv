module d_ff_mux(
    input clk,
    input L,
    input d_0,
    input d_1,
    output reg q
);
    always @(posedge clk) begin
        if (L) begin
            q <= d_0;
        end else begin
            q <= d_1;
        end
    end
endmodule
module top_module (
    input clk,
    input L,
    input [2:0] r,
    output reg [2:0] q
);
    wire [2:0] mux_out;

    // Instantiating the first submodule
    d_ff_mux dff0 (
        .clk(clk),
        .L(L),
        .d_0(r[0]),
        .d_1(q[1] ^ q[2]),
        .q(mux_out[0])
    );

    // Instantiating the second submodule
    d_ff_mux dff1 (
        .clk(clk),
        .L(L),
        .d_0(r[1]),
        .d_1(q[0]),
        .q(mux_out[1])
    );

    // Instantiating the third submodule
    d_ff_mux dff2 (
        .clk(clk),
        .L(L),
        .d_0(r[2]),
        .d_1(q[2]),
        .q(mux_out[2])
    );

    always @(posedge clk) begin
        q <= mux_out;
    end
endmodule
