module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output reg q
);
    always @(*) begin
        if (a == 0 && b == 0) begin
            q = c;
        end else if (a == 0 && b == 1) begin
            q = 1;
        end else if (a == 1 && b == 0) begin
            q = c;
        end else if (a == 1 && b == 1) begin
            q = 1;
        end
    end
endmodule
