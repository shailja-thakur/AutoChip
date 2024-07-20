module top_module (
    input [7:0] a,
    input [7:0] b,
    input [7:0] c,
    input [7:0] d,
    output reg [7:0] min
);

    always @(*) begin
        // Initialize min with the first number
        min = a;
        
        // Compare and find the minimum value
        if (b < min) min = b;
        if (c < min) min = c;
        if (d < min) min = d;
    end

endmodule
