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

    reg [7:0] concat;
    
    always @* begin
        // Concatenate the inputs
        concat = {a[4], b[4], c[4], d[4], e[4], f[4], 2'b11};
        
        // Assign the concatenated value to the outputs
        w = concat;
        x = concat;
        y = concat;
        z = concat;
    end
    
endmodule
