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
    reg [29:0] input_concatenated;
    reg [7:0] output_concatenated;
    
    always @(*) begin
        // concatenate the input vectors
        input_concatenated = {a, b, c, d, e, f};
        
        // concatenate the input vectors with the two 1 bits
        output_concatenated = {input_concatenated, 2'b11};
        
        // split the concatenated output into individual output vectors
        w = output_concatenated[0:7];
        x = output_concatenated[8:15];
        y = output_concatenated[16:23];
        z = output_concatenated[24:31];
    end
    
endmodule
