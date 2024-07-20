module top_module (
    input [2:0] in,
    output [1:0] out
);

    assign out = in[2:0];

endmodule
module top_module (
    input [2:0] in,
    output [1:0] out
);

    assign out = in[1:0] + in[2];

endmodule
