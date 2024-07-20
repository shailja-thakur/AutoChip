module top_module (
    input [3:0] in,
    output [2:0] out_both,
    output [3:1] out_any,
    output [3:0] out_different
);

    reg [1:0] tmp_both;
    reg [3:0] tmp_any;
    reg [3:0] tmp_diff;

    always @(in) begin
        tmp_both[2] = (in[2] & in[3]);
        tmp_both[1] = (in[1] & in[2]);
        tmp_both[0] = (in[0] & in[1]);

        tmp_any[3] = (in[2] | in[3]);
        tmp_any[2] = (in[1] | in[2]);
        tmp_any[1] = (in[0] | in[1]);

        tmp_diff[3] = (in[3] != in[2]);
        tmp_diff[2] = (in[2] != in[1]);
        tmp_diff[1] = (in[1] != in[0]);
        tmp_diff[0] = (in[0] != in[3]);
    end

    assign out_both = tmp_both;
    assign out_any = tmp_any;
    assign out_different = tmp_diff;

endmodule
