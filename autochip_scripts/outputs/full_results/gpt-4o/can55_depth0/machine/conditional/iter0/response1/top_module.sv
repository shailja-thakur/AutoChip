module top_module (
    input [7:0] a,
    input [7:0] b,
    input [7:0] c,
    input [7:0] d,
    output reg [7:0] min
);

    always @* begin
        // Initialize min to the first value
        min = a;

        // Compare and update min if necessary
        if (b < min) begin
            min = b;
        end
        if (c < min) begin
            min = c;
        end
        if (d < min) begin
            min = d;
        end
    end

endmodule
