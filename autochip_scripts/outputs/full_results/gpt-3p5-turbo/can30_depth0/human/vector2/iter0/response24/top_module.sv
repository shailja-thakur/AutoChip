module top_module (
    input [31:0] in,
    output [31:0] out
);

    // Creating a temporary variable to store the reversed byte order
    wire [31:0] tmp;
    
    // Reversing the byte order using concatenation 
    assign tmp = {in[7:0], in[15:8], in[23:16], in[31:24]};
    
    // Assigning the reversed byte order to the output
    assign out = tmp;
    
endmodule
