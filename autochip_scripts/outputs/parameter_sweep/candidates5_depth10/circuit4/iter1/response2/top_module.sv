module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

    reg q;

    always @(*) begin
        if ((!a && d) || (c && !d) || (b && !c && d))
            q <= 1'b1;
        else
            q <= 1'b0;
    end

endmodule
