module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output reg [3:0] out
);

always @(*)begin
    if(sel > 255)
        out = in[255:252];
    else if(sel > 191)
        out = in[191:188];
    else if(sel > 127)
        out = in[127:124];
    else if(sel > 63)
        out = in[63:60];
    else
        out = in[3:0];
end

endmodule
