module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);
    reg [98:0] both_temp;
    reg [99:0] any_temp;
    reg [99:0] diff_temp;

    always @* begin
        for (int i = 0; i < 99; i = i + 1) begin
            if (in[i] && in[i+1])
                both_temp[i] = 1;
            else
                both_temp[i] = 0;
            
            if (in[i] | in[i+1])
                any_temp[i] = 1;
            else
                any_temp[i] = 0;
            
            if (in[i] != in[i+1])
                diff_temp[i] = 1;
            else
                diff_temp[i] = 0;
        end
    end

    assign out_both = both_temp;
    assign out_any = any_temp;
    assign out_different = diff_temp;

endmodule
