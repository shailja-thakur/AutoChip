module top_module (
    input [3:0] in,
    output [2:0] out_both,
    output [3:1] out_any,
    output [3:0] out_different
);
    reg [2:0] temp_both;
    reg [3:1] temp_any;
    reg [3:0] temp_different;

    always @(*) begin
        // Calculate out_both
        temp_both[2] = (in[2] & in[3]);
        temp_both[1] = (in[1] & in[2]);
        temp_both[0] = (in[0] & in[3]);

        // Calculate out_any
        temp_any[3] = (in[3] | in[0]);
        temp_any[2] = (in[2] | in[1]);
        temp_any[1] = (in[1] | in[0]);

        // Calculate out_different
        temp_different[3] = (in[3] != in[0]);
        temp_different[2] = (in[2] != in[1]);
        temp_different[1] = (in[1] != in[0]);
        temp_different[0] = (in[0] != in[3]);
    end

    assign out_both = temp_both;
    assign out_any = temp_any;
    assign out_different = temp_different;
endmodule
