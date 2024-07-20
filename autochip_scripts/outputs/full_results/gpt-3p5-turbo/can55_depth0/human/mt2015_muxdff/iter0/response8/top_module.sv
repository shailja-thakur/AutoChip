module flip_flop(
    input clk,
    input reset,
    input d,
    output reg q
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 0;
        end else begin
            q <= d;
        end
    end
endmodule
module mux_2to1(
    input a,
    input b,
    input sel,
    output reg y
);
    always @(*) begin
        if (sel) begin
            y = b;
        end else begin
            y = a;
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
    // Instantiate flip-flop
    flip_flop FF1 (
        .clk(clk),
        .reset(L),
        .d(q_in),
        .q(Q)
    );

    // Instantiate multiplexer
    mux_2to1 MUX1 (
        .a(r_in),
        .b(Q),
        .sel(L),
        .y(q_in)
    );
endmodule
