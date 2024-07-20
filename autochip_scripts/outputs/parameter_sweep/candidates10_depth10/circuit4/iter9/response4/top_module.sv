module top_module (
    input wire a,
    input wire b,
    input wire c,
    input wire d,
    output reg q
);

    always @(*)
    begin
        if (a == 1'b0 && b == 1'b0 && c == 1'b0 && d == 1'b0)
            q = 1'b0;
        else if (a == 1'b0 && b == 1'b0 && c == 1'b0 && d == 1'b1)
            q = 1'b0;
        else if (a == 1'b0 && b == 1'b0 && c == 1'b1 && d == 1'b0)
            q = 1'b1;
        else if (a == 1'b0 && b == 1'b0 && c == 1'b1 && d == 1'b1)
            q = 1'b1;
        else if (a == 1'b0 && b == 1'b1 && c == 1'b0 && d == 1'b0)
            q = 1'b1;
        else if (a == 1'b0 && b == 1'b1 && c == 1'b0 && d == 1'b1)
            q = 1'b1;
        else if (a == 1'b0 && b == 1'b1 && c == 1'b1 && d == 1'b0)
            q = 1'b1;
        else if (a == 1'b0 && b == 1'b1 && c == 1'b1 && d == 1'b1)
            q = 1'b1;
        else if (a == 1'b1 && b == 1'b0 && c == 1'b0 && d == 1'b0)
            q = 1'b0;
        else if (a == 1'b1 && b == 1'b0 && c == 1'b0 && d == 1'b1)
            q = 1'b0;
        else if (a == 1'b1 && b == 1'b0 && c == 1'b1 && d == 1'b0)
            q = 1'b1;
        else if (a == 1'b1 && b == 1'b0 && c == 1'b1 && d == 1'b1)
            q = 1'b1;
        else if (a == 1'b1 && b == 1'b1 && c == 1'b0 && d == 1'b0)
            q = 1'b1;
        else if (a == 1'b1 && b == 1'b1 && c == 1'b0 && d == 1'b1)
            q = 1'b1;
        else if (a == 1'b1 && b == 1'b1 && c == 1'b1 && d == 1'b0)
            q = 1'b1;
        else if (a == 1'b1 && b == 1'b1 && c == 1'b1 && d == 1'b1)
            q = 1'b1;
    end

endmodule
