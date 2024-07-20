module top_module (
    input clk,
    input x,
    output reg z
);

reg flop1;
reg flop2;
reg flop3;
reg rst;

wire xor_output;
wire and_output;
wire or_output;

xor2 xor_gate (
    .a(flop1),
    .b(flop2),
    .z(xor_output)
);

and2 and_gate (
    .a(flop2),
    .b(~x),
    .z(and_output)
);

or2 or_gate (
    .a(flop3),
    .b(~x),
    .z(or_output)
);

xnor3 xnor_gate (
    .a(flop1),
    .b(flop2),
    .c(flop3),
    .z(z)
);

always @(posedge clk) begin
    if (rst) begin
        flop1 <= 0;
        flop2 <= 0;
        flop3 <= 0;
    end else begin
        flop1 <= xor_output;
        flop2 <= and_output;
        flop3 <= or_output;
    end
end

endmodule
module xor2 (
    input a,
    input b,
    output z
);
    assign z = a ^ b;
endmodule
module and2 (
    input a,
    input b,
    output z
);
    assign z = a & b;
endmodule
module or2 (
    input a,
    input b,
    output z
);
    assign z = a | b;
endmodule
module xnor3 (
    input a,
    input b,
    input c,
    output z
);
    assign z = ~(a ^ b ^ c);
endmodule
