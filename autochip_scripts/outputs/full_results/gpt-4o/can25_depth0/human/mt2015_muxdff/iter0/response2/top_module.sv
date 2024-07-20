module sub_module(
    input clk,
    input L,
    input D0,
    input D1,
    output reg Q
);
    always @(posedge clk) begin
        if (L)
            Q <= D0;
        else
            Q <= D1;
    end
endmodule
module top_module(
    input clk,
    input L,
    input [2:0] r_in,
    output [2:0] Q
);
    wire [2:0] mux_outputs;
    
    // Instantiate three submodules for each bit of 3-bit vector
    sub_module u0 (
        .clk(clk),
        .L(L),
        .D0(r_in[0]),
        .D1(Q[1] ^ Q[2]),
        .Q(Q[0])
    );

    sub_module u1 (
        .clk(clk),
        .L(L),
        .D0(r_in[1]),
        .D1(Q[0]),
        .Q(Q[1])
    );

    sub_module u2 (
        .clk(clk),
        .L(L),
        .D0(r_in[2]),
        .D1(Q[2]),
        .Q(Q[2])
    );

endmodule
