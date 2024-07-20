module top_module (
    input [3:0] in,
    output [2:0] out_both,
    output [3:1] out_any,
    output [3:0] out_different
);
    
    reg [3:0] in_shifted;
    
    always @* begin
        in_shifted[3] = in[0];
        in_shifted[2] = in[3];
        in_shifted[1:0] = in[2:1];
        
        out_both[2] = (in[2] & in_shifted[2]);
        out_both[1] = (in[1] & in_shifted[1]);
        out_both[0] = (in[0] & in_shifted[0]);
        
        out_any[3] = (in[3] | in_shifted[3]);
        out_any[2] = (in_shifted[2] | in[2]);
        out_any[1] = (in_shifted[1] | in[1]);
        
        out_different[3] = (in[3] != in_shifted[3]);
        out_different[2] = (in[2] != in_shifted[2]);
        out_different[1] = (in[1] != in_shifted[1]);
        out_different[0] = (in[0] != in_shifted[0]);
    end
    
endmodule
