module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);
    reg q;
    
    always @(*) begin
        if (c & d) begin
            q = 1;
        end
        else if (a & b & ~c & ~d) begin
            q = 0;
        end
        else if (a & b & c & ~d) begin
            q = 1;
        end
        else begin
            q = 1;
        end
    end
endmodule
