module top_module (
    input [7:0] a,
    input [7:0] b,
    input [7:0] c,
    input [7:0] d,
    output reg [7:0] min
);

always_comb begin
    min = a; // Assign initial value of a to min
    if (b < min) // Compare b with min
        min = b; // Update min if b is smaller
    if (c < min) // Compare c with min
        min = c; // Update min if c is smaller
    if (d < min) // Compare d with min
        min = d; // Update min if d is smaller
end

endmodule
