module top_module (
    input [7:0] a,
    input [7:0] b,
    input [7:0] c,
    input [7:0] d,
    output reg [7:0] min
);
    always @* begin
        min = a; // Start by assuming 'a' is the minimum
        if (b < min) min = b; // Check if 'b' is less than the current minimum
        if (c < min) min = c; // Check if 'c' is less than the current minimum
        if (d < min) min = d; // Check if 'd' is less than the current minimum
    end
endmodule
