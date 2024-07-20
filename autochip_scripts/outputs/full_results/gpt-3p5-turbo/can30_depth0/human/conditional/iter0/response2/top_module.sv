module top_module (
    input [7:0] a,
    input [7:0] b,
    input [7:0] c,
    input [7:0] d,
    output [7:0] min
);

    reg [7:0] result;

    // Compare a and b
    always @*
    begin
        if (a < b)
            result = a;
        else
            result = b;
    end
    
    // Compare result and c
    always @*
    begin
        if (result < c)
            min = result;
        else
            min = c;
    end
    
    // Compare min and d
    always @*
    begin
        if (min < d)
            min = min;
        else
            min = d;
    end
    
endmodule
