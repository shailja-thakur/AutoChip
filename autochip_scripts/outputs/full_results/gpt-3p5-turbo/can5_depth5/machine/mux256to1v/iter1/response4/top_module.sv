module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

    reg [3:0] out_reg;
    
    always @* begin
        // Declare start_index as a local variable
        integer start_index;
        
        // Calculate the starting index of the 4-bit block in the input vector
        start_index = sel * 4;
        
        // Extract the 4-bit block from the input vector
        out_reg = in[start_index +: 4];
    end
    
    // Assign the output
    assign out = out_reg;
    
endmodule
