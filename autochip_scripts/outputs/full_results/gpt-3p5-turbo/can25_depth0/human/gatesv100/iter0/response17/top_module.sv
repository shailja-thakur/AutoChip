module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

    reg [98:0] both_temp;
    reg [99:2] any_temp;
    
    // Relationship: (1) out_both
    always @* begin
        for (int i = 0; i < 99; i = i + 1) begin
            if (in[i] == 1 && in[i+1] == 1)
                both_temp[i] = 1;
            else
                both_temp[i] = 0;
        end
    end
    
    // Relationship: (2) out_any
    always @* begin
        any_temp[0] = in[0] | in[1];
        any_temp[99] = in[99] | in[0];
        for (int i = 1; i < 99; i = i + 1) begin
            any_temp[i] = in[i] | in[i+1];
        end
    end
    
    // Relationship: (3) out_different
    always @* begin
        out_different[0] = in[0] != in[99];
        for (int i = 1; i < 100; i = i + 1) begin
            out_different[i] = in[i] != in[i-1];
        end
    end
    
    assign out_both = both_temp;
    assign out_any = any_temp;
endmodule
