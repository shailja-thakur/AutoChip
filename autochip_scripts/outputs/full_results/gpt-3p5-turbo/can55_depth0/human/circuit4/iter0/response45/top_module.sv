module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);
    
    reg q;

    always @(*) begin
        if (a == 1'b0 && b == 1'b0 && c == 1'b1 && d == 1'b0)
            q = 1'b1;
        else
            q = 1'b0;
    end

endmodule
