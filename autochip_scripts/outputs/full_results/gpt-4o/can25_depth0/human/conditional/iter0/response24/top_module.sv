module top_module (
    input [7:0] a,
    input [7:0] b,
    input [7:0] c,
    input [7:0] d,
    output reg [7:0] min
);

    always @(*) begin
        // Initial assumption
        min = a;

        // Compare with b
        if (b < min) min = b;

        // Compare with c
        if (c < min) min = c;

        // Compare with d
        if (d < min) min = d;
    end

endmodule
