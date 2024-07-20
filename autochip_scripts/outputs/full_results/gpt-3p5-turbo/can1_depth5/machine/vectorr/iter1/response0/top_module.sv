module top_module (
    input [7:0] in,
    output [7:0] out
);
    
    // Assign the output based on the reverse of the input
    assign out = {in[0], in[1], in[2], in[3], in[4], in[5], in[6], in[7]};

endmodule
