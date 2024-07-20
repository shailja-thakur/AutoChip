module top_module(
    input a, 
    input b,
    input c,
    output reg out
);

    always @(*) begin
        if (a == 1 || (b == 1 && c == 1) || (b == 0 && c == 1) || (b == 1 && c == 0)) begin
            out = 1;
        end else begin
            out = 0;
        end
    end
endmodule
