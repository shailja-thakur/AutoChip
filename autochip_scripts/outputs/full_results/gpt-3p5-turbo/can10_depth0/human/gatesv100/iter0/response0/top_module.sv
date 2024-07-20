module top_module (
    input [99:0] in,
    output reg [98:0] out_both,
    output reg [99:1] out_any,
    output reg [99:0] out_different
);
    
    always @* begin
        // Calculate out_both
        for (int i = 0; i < 99; i = i + 1)
            out_both[i] = in[i] & in[i+1];
        
        // Calculate out_any
        for (int i = 2; i < 100; i = i + 1)
            out_any[i] = in[i] | in[i-1];
        
        // Calculate out_different
        for (int i = 0; i < 99; i = i + 1)
            out_different[i] = in[i] != in[i+1];
        out_different[99] = in[99] != in[0];
    end
endmodule
