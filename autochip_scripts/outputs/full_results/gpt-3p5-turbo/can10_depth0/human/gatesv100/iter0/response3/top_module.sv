module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

    reg [99:0] in_shifted;
    reg [98:0] out_both_temp;
    reg [99:1] out_any_temp;
    reg [99:0] out_different_temp;
    
    always @* begin
        // Calculate out_both
        out_both_temp[0] = in[0] & in[99];
        for (int i = 1; i < 99; i = i + 1) begin
            out_both_temp[i] = in[i] & in[i-1];
        end
        
        // Calculate out_any
        out_any_temp[99] = in[99] | in[0];
        for (int i = 0; i < 99; i = i + 1) begin
            out_any_temp[i] = in[i] | in[i+1];
        end
        
        // Calculate out_different
        out_different_temp[0] = in[0] != in[99];
        for (int i = 1; i < 100; i = i + 1) begin
            out_different_temp[i] = in[i] != in[i-1];
        end
    end
    
    assign out_both = out_both_temp;
    assign out_any = out_any_temp;
    assign out_different = out_different_temp;
    
endmodule
