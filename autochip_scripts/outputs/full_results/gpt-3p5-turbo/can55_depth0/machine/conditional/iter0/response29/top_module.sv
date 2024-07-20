module top_module (
    input [7:0] a,
    input [7:0] b,
    input [7:0] c,
    input [7:0] d,
    output reg [7:0] min
);

    // Variable to store the minimum value
    reg [7:0] temp;

    always_comb begin
        // Assign the value of a to min as a starting point
        temp = a;

        // Compare temp with b, c, and d
        if (b < temp)
            temp = b;
        if (c < temp)
            temp = c;
        if (d < temp)
            temp = d;

        // Assign the minimum value to min
        min = temp;
    end

endmodule
