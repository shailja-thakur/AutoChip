module flipflop(input clk, input q_in, output reg Q);
    always @(posedge clk)
        Q <= q_in;
endmodule
module mux(input L, input d0, input d1, output reg Q);
    always @(L or d0 or d1)
        if (L)
            Q <= d0;
        else
            Q <= d1;
endmodule
module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);
    wire [2:0] r;
    wire [2:0] q;

    flipflop ff0(.clk(clk), .q_in(q_in), .Q(q[0]));
    flipflop ff1(.clk(clk), .q_in(q[0]), .Q(q[1]));
    flipflop ff2(.clk(clk), .q_in(q[1]), .Q(q[2]));

    mux mux0(.L(L), .d0(r_in), .d1(q[2]), .Q(Q));

    assign r = {r_in, q[2]};

endmodule
