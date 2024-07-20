module top_module (
    input [4:0] a,
    input [4:0] b,
    input [4:0] c,
    input [4:0] d,
    input [4:0] e,
    input [4:0] f,
    output [7:0] w,
    output [7:8] x,
    output [7:0] y,
    output [7:0] z
); 
 
    wire [31:0] concatenated_input;     
    assign concatenated_input = {a, b, c, d, e, f, 2'b11}; 
 
    assign w = concatenated_input[31:24];
    assign x = concatenated_input[23:16];
    assign y = concatenated_input[15:8];
    assign z = concatenated_input[7:0];
 
endmodule
