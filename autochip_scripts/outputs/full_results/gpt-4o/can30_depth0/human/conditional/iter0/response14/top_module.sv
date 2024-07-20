module top_module (
    input [7:0] a,
    input [7:0] b,
    input [7:0] c,
    input [7:0] d,
    output reg [7:0] min
);

    reg [7:0] min_ab;
    reg [7:0] min_cd;

    always @(*) begin
        // Find the minimum of a and b
        if (a < b)
            min_ab = a;
        else
            min_ab = b;
        
        // Find the minimum of c and d
        if (c < d)
            min_cd = c;
        else
            min_cd = d;

        // Find the minimum of min_ab and min_cd
        if (min_ab < min_cd)
            min = min_ab;
        else
            min = min_cd;
    end

endmodule
