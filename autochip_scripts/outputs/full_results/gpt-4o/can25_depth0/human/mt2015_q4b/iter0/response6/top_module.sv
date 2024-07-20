module top_module(
    input x,
    input y,
    output reg z);

    always @(*) begin
        if (~x & ~y)
            z = 1;
        else if (x & ~y)
            z = 0;
        else if (~x & y)
            z = 0;
        else if (x & y)
            z = 1;
        else
            z = 1'bx;  // To cover all possible cases
    end

endmodule
