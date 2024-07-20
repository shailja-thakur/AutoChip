module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

    // Declare internal wire for out_both
    wire [98:0] both_temp;

    // Calculate out_both
    assign both_temp[98] = in[98] & in[99];
    assign both_temp[97:0] = in[97:0] & in[98:1];
    assign out_both = both_temp;

    // Calculate out_any
    assign out_any[1:99] = in[0:98] | in[1:99];
    assign out_any[0] = in[0];

    // Calculate out_different
    assign out_different[98] = (in[98] !== in[99]);
    assign out_different[97:0] = (in[97:0] !== in[98:0]);

endmodule
