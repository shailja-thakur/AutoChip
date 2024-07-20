module flipflop(
    input clk,
    input [2:0] d,
    output reg [2:0] q
);

    always @(posedge clk) begin
        q <= d;
    end

endmodule
module mux_2to1(
    input [2:0] a,
    input [2:0] b,
    input sel,
    output reg [2:0] out
);

    always @(a, b, sel) begin
        if (sel)
            out <= b;
        else
            out <= a;
    end

endmodule
module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);
    
    wire [2:0] q1, q2, q3;

    flipflop ff1 (
        .clk(clk),
        .d(r_in),
        .q(q1)
    );

    flipflop ff2 (
        .clk(clk),
        .d(q1),
        .q(q2)
    );

    flipflop ff3 (
        .clk(clk),
        .d(q2),
        .q(q3)
    );

    mux_2to1 mux (
        .a(ff3.q),
        .b(q_in),
        .sel(L),
        .out(Q)
    );

endmodule
