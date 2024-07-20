module top_module (
    input [3:0] in,
    output [2:0] out_both,
    output [3:0] out_any,
    output [3:0] out_different
);
    // Assign bitwise AND operation
    assign out_both = in[2:0] & in[3:1];
    
    // Assign bitwise OR operation
    assign out_any = { (in[3] | in[2]), (in[2] | in[1]), (in[1] | in[0]), (in[0] | in[3]) }; 

    // Assign bitwise XOR operation
    assign out_different = in ^ { in[3:1], in[0] };
endmodule
