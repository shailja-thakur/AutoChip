module mux_flipflop (
    input r,
    input L,
    input clk,
    input q_in,
    output reg q_out
);
    always @(posedge clk) begin
        if (L) begin
            q_out <= r;
        end else begin
            q_out <= q_in;
        end
    end
endmodule
module top_module(
    input clk,
    input L,
    input [2:0] r,
    output [2:0] q  
);
    wire [2:0] q_internal;
    wire [2:0] mux_output;

    assign mux_output[0] = q_internal[1] ^ q_internal[2];
    assign mux_output[1] = q_internal[0];
    assign mux_output[2] = q_internal[2];

    // Instantiate the submodules
    mux_flipflop inst0 (
        .r(r[0]),
        .L(L),
        .clk(clk),
        .q_in(mux_output[0]),
        .q_out(q_internal[0])
    );

    mux_flipflop inst1 (
        .r(r[1]),
        .L(L),
        .clk(clk),
        .q_in(mux_output[1]),
        .q_out(q_internal[1])
    );

    mux_flipflop inst2 (
        .r(r[2]),
        .L(L),
        .clk(clk),
        .q_in(mux_output[2]),
        .q_out(q_internal[2])
    );

    assign q = q_internal;
endmodule
