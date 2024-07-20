module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

    wire [9:0] index;
    
    assign index = sel * 4;
    assign out = in[index+3 : index];
    
endmodule
