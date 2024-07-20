module top_module (
    input [7:0] a,
    input [7:0] b,
    input [7:0] c,
    input [7:0] d,
    output reg [7:0] min
);

    always @* begin
        // Initialize min with the value of a
        min = a;

        // Compare min with b, if b is less than min, update min
        if (b < min) begin
            min = b;
        end

        // Compare min with c, if c is less than min, update min
        if (c < min) begin
            min = c;
        end

        // Compare min with d, if d is less than min, update min
        if (d < min) begin
            min = d;
        end
    end

endmodule
