module top_module (
    input clk,
    input x,
    output z
);

    reg flop1;
    reg flop2;
    reg flop3;

    wire xor_output;
    wire and_output;
    wire or_output;

    assign xor_output = flop1 ^ flop2;
    assign and_output = ~flop2 & x;
    assign or_output = ~flop2 | x;

    xor2 #(.N(1)) xor_gate (
        .a(flop1),
        .b(flop1),
        .z(xor_output)
    );

    and2 #(.N(1)) and_gate (
        .a(flop2),
        .b(x),
        .z(and_output)
    );

    or2 #(.N(1)) or_gate (
        .a(flop3),
        .b(x),
        .z(or_output)
    );

    xnor3 #(.N(1)) xnor_gate (
        .a(flop1),
        .b(flop2),
        .c(flop3),
        .z(z)
    );

    always @(posedge clk) begin
        flop1 <= xor_output;
        flop2 <= ~and_output;
        flop3 <= ~or_output;
    end

endmodule
