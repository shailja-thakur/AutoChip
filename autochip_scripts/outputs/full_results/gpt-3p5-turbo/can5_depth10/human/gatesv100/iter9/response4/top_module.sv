module top_module (
    input [99:0] in,
    output reg [98:0] out_both,
    output reg [99:1] out_any,
    output reg [99:0] out_different
);

    always @* begin
        out_both = in[98:0] & in[99:1];
    end
    
    always @* begin
        out_any[0] = in[0];
        out_any[99:1] = in[99:1] | in[0:98];
    end
    
    always @* begin
        out_different = in ^ {in[0], in[99:1]};
    end

endmodule
