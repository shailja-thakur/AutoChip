module top_module (
    input [3:0] in,
    output [2:0] out_both,
    output [3:1] out_any,
    output [3:0] out_different
);
    reg [3:0] shifted_in;
    reg [2:0] shifted_out_both;
    reg [3:1] shifted_out_any;
    reg [3:0] shifted_out_different;
    
    always @ (*) begin
        shifted_in = {in[2:0], in[3]}; // Shift the input vector to the left
        shifted_out_both[2] = shifted_in[2] && shifted_in[1];
        shifted_out_both[1] = shifted_in[1] && shifted_in[0];
        shifted_out_both[0] = shifted_in[0] && shifted_in[3];
        
        shifted_out_any[3] = shifted_in[3] || shifted_in[0];
        shifted_out_any[2] = shifted_in[2] || shifted_in[1];
        shifted_out_any[1] = shifted_in[1] || shifted_in[0];
        
        shifted_out_different[3] = shifted_in[3] != shifted_in[0];
        shifted_out_different[2] = shifted_in[2] != shifted_in[1];
        shifted_out_different[1] = shifted_in[1] != shifted_in[0];
        shifted_out_different[0] = shifted_in[0] != shifted_in[3];
        
        out_both = shifted_out_both;
        out_any = shifted_out_any;
        out_different = shifted_out_different;
    end
endmodule
