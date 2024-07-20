module top_module (
    input [3:0] in,
    output [2:0] out_both,
    output [3:1] out_any,
    output [3:0] out_different
);
    reg [2:0] temp;
    reg [0:3] temp_any;
    
    // out_both
    always @*
    begin
        temp[2] = in[2] & in[3];
        temp[1] = in[1] & in[2];
        temp[0] = in[0] & in[1];
    end
    
    // out_any
    always @*
    begin
        temp_any[3] = in[2] | in[3];
        temp_any[2] = in[1] | in[2];
        temp_any[1] = in[0] | in[1];
        temp_any[0] = in[3] | in[0];
    end
    
    // out_different
    always @*
    begin
        out_different[3] = in[2] ^ in[3];
        out_different[2] = in[1] ^ in[2];
        out_different[1] = in[0] ^ in[1];
        out_different[0] = in[3] ^ in[0];
    end
    
    assign out_both = temp;
    assign out_any = temp_any;
    
endmodule
