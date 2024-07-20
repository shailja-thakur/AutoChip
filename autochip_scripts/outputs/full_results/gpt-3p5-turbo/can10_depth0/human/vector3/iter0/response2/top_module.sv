module top_module (
    input [4:0] a,
    input [4:0] b,
    input [4:0] c,
    input [4:0] d,
    input [4:0] e,
    input [4:0] f,
    output [7:0] w,
    output [7:0] x,
    output [7:0] y,
    output [7:0] z
);
    wire [29:0] inputs;     // Concatenation of all input vectors
    wire [31:0] output;     // Output vector
    
    assign inputs = {a, b, c, d, e, f};
    assign output = {inputs, 2'b11};
    
    assign {w, x, y, z} = output;
    
endmodule
