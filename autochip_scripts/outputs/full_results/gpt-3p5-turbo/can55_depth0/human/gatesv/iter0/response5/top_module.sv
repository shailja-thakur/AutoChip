module top_module (
    input [3:0] in,
    output [2:0] out_both,
    output [3:1] out_any,
    output [3:0] out_different
);

    wire [3:1] in_wrap;
    wire [2:0] out_both_temp;

    // Wrap the input vector
    assign in_wrap = {in[2:0], in[3]};

    // Calculate out_both
    assign out_both_temp[0] = in_wrap[0] & in_wrap[1];
    assign out_both_temp[1] = in_wrap[1] & in_wrap[2];
    assign out_both_temp[2] = in_wrap[2] & in_wrap[3];

    // Calculate out_any
    assign out_any[1] = in[2] | in[1];
    assign out_any[2] = in[3] | in[2];
    assign out_any[3] = in[0] | in[3];

    // Calculate out_different
    assign out_different[0] = (in[3] == in[0]);
    assign out_different[1] = (in[0] == in[1]);
    assign out_different[2] = (in[1] == in[2]);
    assign out_different[3] = (in[2] == in[3]);

    // Assign outputs
    assign out_both = out_both_temp;
endmodule
