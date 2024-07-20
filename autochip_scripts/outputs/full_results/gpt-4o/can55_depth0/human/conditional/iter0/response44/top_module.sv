module top_module (
    input [7:0] a,
    input [7:0] b,
    input [7:0] c,
    input [7:0] d,
    output reg [7:0] min
);

    always @(*) begin
        // Find the minimum of a and b
        min = (a < b) ? a : b;
        // Find the minimum of the previously found minimum and c
        min = (min < c) ? min : c;
        // Find the minimum of the previously found minimum and d
        min = (min < d) ? min : d;
    end

endmodule
