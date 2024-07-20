module top_module (
    input [31:0] in,
    output [31:0] out
);
    
    assign out[31:24] = in[7:0];  // Assign first 8 bits of input to last 8 bits of output
    assign out[23:16] = in[15:8]; // Assign second 8 bits of input to second last 8 bits of output
    assign out[15:8] = in[23:16]; // Assign third 8 bits of input to third last 8 bits of output
    assign out[7:0] = in[31:24];  // Assign last 8 bits of input to first 8 bits of output

endmodule
