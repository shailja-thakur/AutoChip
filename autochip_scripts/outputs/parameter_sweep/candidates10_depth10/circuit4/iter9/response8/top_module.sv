module top_module (
    input wire a,
    input wire b,
    input wire c,
    input wire d,
    output reg q
);

    always @(*)
    begin
        if (a & b) 
            q = 1'b0;
        else if ((c & d) || (c & ~d))
            q = 1'b1;
        else if (~c & d)
            q = b;
        else
            q = 1'b0;
    end

endmodule
