module top_module (
    input [3:0] in,
    output [2:0] out_both,
    output [3:1] out_any,
    output [3:0] out_different
);

    reg [2:0] temp_out_both;
    reg [3:1] temp_out_any;
    reg [3:0] temp_out_different;

    always @* begin
        // out_both
        temp_out_both[0] = in[0] & in[3];
        temp_out_both[1] = in[1] & in[0];
        temp_out_both[2] = in[2] & in[1];

        // out_any
        temp_out_any[3] = in[2] | in[1];
        temp_out_any[2] = in[1] | in[0];
        temp_out_any[1] = in[0] | in[3];

        // out_different
        temp_out_different[3] = (in[3] != in[2]) ? 1'b1 : 1'b0;
        temp_out_different[2] = (in[2] != in[1]) ? 1'b1 : 1'b0;
        temp_out_different[1] = (in[1] != in[0]) ? 1'b1 : 1'b0;
        temp_out_different[0] = (in[0] != in[3]) ? 1'b1 : 1'b0;
    end

    assign out_both = temp_out_both;
    assign out_any = temp_out_any;
    assign out_different = temp_out_different;

endmodule
