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

    reg [31:0] concatenated_input;
    
    always @(*) begin
        concatenated_input = {a, b, c, d, e, f};
    end
    
    assign {w, x, y, z} = {concatenated_input, 2'b11};

endmodule
