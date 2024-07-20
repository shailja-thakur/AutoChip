module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

    reg [98:0] temp_both;
    reg [99:0] temp_any;
    reg [99:0] temp_diff;
    
    always @(in) begin
        // Calculation for out_both
        temp_both[0] = in[0] & in[99];
        for (int i = 1; i < 99; i = i + 1) begin
            temp_both[i] = in[i] & in[i-1];
        end
        
        // Calculation for out_any
        temp_any[99] = in[99];
        for (int i = 98; i >= 1; i = i - 1) begin
            temp_any[i] = in[i] | in[i+1];
        end
        
        // Calculation for out_different
        temp_diff[0] = in[0] != in[99];
        for (int i = 1; i < 100; i = i + 1) begin
            temp_diff[i] = in[i] != in[i-1];
        end
    end
    
    assign out_both = temp_both;
    assign out_any = temp_any[99:1];
    assign out_different = temp_diff;
    
endmodule
