module top_module (
    input [4:0] a,
    input [4:0] b,
    input [4:0] c,
    input [4:0] d,
    input [4:0] e,
    input [4:0] f,
    output [7:0] w,
    output [7:0] x,
    output [7:8] y,
    output [7:8] z
);

    wire [31:0] concat_data;
    
    // Concatenate input vectors and add two 1 bits at LSB
    assign concat_data = {a, b, c, d, e, f, 2'b11};
    
    // Split the concatenated data into 8-bit output vectors
    assign w = concat_data[31:24];
    assign x = concat_data[23:16];
    assign y = concat_data[15:8];
    assign z = concat_data[7:0];
    
endmodule
