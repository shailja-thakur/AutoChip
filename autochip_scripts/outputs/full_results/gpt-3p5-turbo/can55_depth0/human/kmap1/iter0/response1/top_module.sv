module top_module(
    input a, 
    input b,
    input c,
    output out
);
    reg out;

    always @(*) begin
        if (a == 0 && b == 0 && c == 0)
            out = 0;
        else
            out = 1;
    end

endmodule
