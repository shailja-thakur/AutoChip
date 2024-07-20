module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

    wire [3:0] index = (sel << 2);
    
    assign out = in[index +: 4];

endmodule
