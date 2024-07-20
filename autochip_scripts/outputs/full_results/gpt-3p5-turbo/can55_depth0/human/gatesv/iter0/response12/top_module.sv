module top_module (
    input [3:0] in,
    output [2:0] out_both,
    output [3:1] out_any,
    output [3:0] out_different
);

    wire [3:0] in_shifted;

    // Shift the input vector by one position to the right
    assign in_shifted = {in[2:0], in[3]};

    // Calculate out_both
    assign out_both[0] = in[0] & in_shifted[0];
    assign out_both[1] = in[1] & in_shifted[1];
    assign out_both[2] = in[2] & in_shifted[2];

    // Calculate out_any
    assign out_any[1] = in[1] | in_shifted[1];
    assign out_any[2] = in[2] | in_shifted[2];
    assign out_any[3] = in[3] | in[0];

    // Calculate out_different
    assign out_different[0] = in[0] != in_shifted[0];
    assign out_different[1] = in[1] != in_shifted[1];
    assign out_different[2] = in[2] != in_shifted[2];
    assign out_different[3] = in[3] != in[0];

endmodule
