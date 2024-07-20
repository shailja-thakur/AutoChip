module top_module (
    input [7:0] a,
    input [7:0] b,
    input [7:0] c,
    input [7:0] d,
    output reg [7:0] min
);
    always @(*) begin
        min = a; // Start with a as the initial minimum
        if (b < min) min = b; // Compare and update if b is less than current min
        if (c < min) min = c; // Compare and update if c is less than current min
        if (d < min) min = d; // Compare and update if d is less than current min
    end
endmodule
