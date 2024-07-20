module top_module (
    input wire a,
    input wire b,
    input wire c,
    input wire d,
    output wire q
);

    always @(*)
    begin
        if (a & b & ~c & ~d)
            q = 1'b0;
        else if (c & d)
            q = 1'b1;
        else
            q = b;
    end

endmodule
