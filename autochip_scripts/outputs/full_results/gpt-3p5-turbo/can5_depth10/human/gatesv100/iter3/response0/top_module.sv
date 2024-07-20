module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

    assign out_both = in[98:0] & in[99:1];
    
    always @* begin
        out_any[99] = in[99] | in[0];
        for (int i = 98; i > 0; i = i - 1) begin
            out_any[i] = in[i] | in[i-1];
        end
    end
    
    always @* begin
        out_different[99] = 1'b0;
        for (int i = 98; i >= 0; i = i - 1) begin
            out_different[i] = in[i] ^ in[i+1];
        end
    end
    
endmodule
