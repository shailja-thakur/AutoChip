module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);
    // Define temporary variables to store intermediate values
    reg [99:0] temp_both;
    reg [99:1] temp_any;
    reg [99:0] temp_different;
    
    // Calculate out_both
    always @* begin
        temp_both[0] = in[0] & in[99];
        for (int i = 1; i < 100; i = i + 1) begin
            temp_both[i] = in[i] & in[i-1];
        end
    end
    
    // Calculate out_any
    always @* begin
        temp_any[99] = in[98] | in[99];
        for (int i = 98; i >= 1; i = i - 1) begin
            temp_any[i] = in[i] | in[i-1];
        end
    end
    
    // Calculate out_different
    always @* begin
        temp_different[0] = in[0] != in[99];
        for (int i = 1; i < 100; i = i + 1) begin
            temp_different[i] = in[i] != in[i-1];
        end
    end
    
    // Assign the temporary variables to the module outputs
    assign out_both = temp_both[99:1];
    assign out_any = temp_any;
    assign out_different = temp_different;
    
endmodule
