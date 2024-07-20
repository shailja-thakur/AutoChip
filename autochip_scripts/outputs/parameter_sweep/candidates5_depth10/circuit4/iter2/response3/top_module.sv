module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output reg q
);

    always @(*) begin
        if (!a && d)
            q = 1'b0;
        else if (c && !d)
            q = 1'b1;
        else if (b && c && d)
            q = 1'b1;
        else
            q = 1'b0;
    end

endmodule
