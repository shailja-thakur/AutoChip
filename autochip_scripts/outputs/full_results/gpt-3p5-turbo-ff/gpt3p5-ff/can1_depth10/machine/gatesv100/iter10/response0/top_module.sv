module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);
    reg [99:0] shifted_in;
    
    always @(*) begin
        shifted_in[99] = in[0];
        for (i = 99; i >= 1; i = i - 1) begin
            shifted_in[i-1] = in[i];
        end
    end
    
    assign out_both = in[98:0] & shifted_in[98:0];
    assign out_any = in | shifted_in;
    assign out_different = {in[0] ^ shifted_in[99], in[99:1] ^ shifted_in[98:0]};
endmodule
