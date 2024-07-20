module top_module (
    input [7:0] a,
    input [7:0] b,
    input [7:0] c,
    input [7:0] d,
    output reg [7:0] min
);

    always @(*) begin
        // Start by assuming 'a' is the minimum
        min = a;

        // Compare 'min' with 'b'
        if (b < min) begin
            min = b;
        end

        // Compare 'min' with 'c'
        if (c < min) begin
            min = c;
        end

        // Compare 'min' with 'd'
        if (d < min) begin
            min = d;
        end
    end

endmodule
