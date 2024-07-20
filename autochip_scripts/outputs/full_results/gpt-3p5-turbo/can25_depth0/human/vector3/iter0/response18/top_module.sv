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

    reg [29:0] input_vector;
    reg [1:0] two_ones;

    assign w = {input_vector, two_ones};
    assign x = {input_vector, two_ones};
    assign y = {input_vector, two_ones};
    assign z = {input_vector, two_ones};

    always @* begin
        input_vector = {a, b, c, d, e, f};
        two_ones = 2'b11;
    end

endmodule
