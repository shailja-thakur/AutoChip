module top_module(
    input [99:0] in,
    output reg [98:0] out_both,
    output reg [99:1] out_any,
    output reg [99:0] out_different
);

always @* begin
    // out_both
    for (int i = 0; i < 99; i=i+1) begin
        if (in[i] && in[i+1])
            out_both[i] = 1;
        else
            out_both[i] = 0;
    end
  
    // out_any
    for (int i = 1; i < 99; i=i+1) begin
        if (in[i] || in[i-1])
            out_any[i] = 1;
        else
            out_any[i] = 0;
    end
  
    // out_different
    for (int i = 0; i < 99; i=i+1) begin
        if (in[i] != in[(i+1) % 100])
            out_different[i] = 1;
        else
            out_different[i] = 0;
    end
end

endmodule
