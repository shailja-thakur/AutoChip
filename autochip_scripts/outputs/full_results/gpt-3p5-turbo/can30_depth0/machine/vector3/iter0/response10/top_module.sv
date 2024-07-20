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

    wire [4:0] concat_input1 = a;
    wire [4:0] concat_input2 = b;
    wire [4:0] concat_input3 = c;
    wire [4:0] concat_input4 = d;
    wire [4:0] concat_input5 = e;
    wire [4:0] concat_input6 = f;
    wire last_concat_bit = 1'b1;
    
    wire [7:0] concat_output = {concat_input6, concat_input5, concat_input4, concat_input3, concat_input2, concat_input1, last_concat_bit};

    assign {w, x, y, z} = concat_output;

endmodule
