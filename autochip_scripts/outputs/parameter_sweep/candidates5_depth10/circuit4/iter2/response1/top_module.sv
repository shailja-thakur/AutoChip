module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output reg q
);

    always @(*) begin
        q = (!a && d) || (c && !d) || (b && c && d);
    end

    initial begin
        q = 0;
    end

endmodule
