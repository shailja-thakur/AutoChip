module top_module (
    input [7:0] a,
    input [7:0] b,
    input [7:0] c,
    input [7:0] d,
    output reg [7:0] min
);

always_comb begin
    min = a; // Initialize min to the value of a

    // Compare min with the other inputs and update min if necessary
    if (b < min) min = b;
    if (c < min) min = c;
    if (d < min) min = d;
end

endmodule
