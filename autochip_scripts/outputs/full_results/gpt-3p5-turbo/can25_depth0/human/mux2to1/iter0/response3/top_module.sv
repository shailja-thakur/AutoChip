module top_module (
    input wire a,
    input wire b,
    input wire sel,
    output wire out
);

    assign out = (sel == 0) ? a : b;

endmodule
