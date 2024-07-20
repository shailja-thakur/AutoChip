module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output reg q
);

always @(*) begin
    if (a == 0 && b == 0) begin
        q = (c == 0 && d == 0) ? 1 :
            (c == 0 && d == 1) ? 0 :
            (c == 1 && d == 0) ? 0 : 
            1;
    end 
    else if (a == 0 && b == 1) begin
        q = (c == 0 && d == 0) ? 0 :
            (c == 0 && d == 1) ? 1 :
            (c == 1 && d == 0) ? 1 :
            0;
    end 
    else if (a == 1 && b == 0) begin
        q = (c == 0 && d == 0) ? 0 :
            (c == 0 && d == 1) ? 1 :
            (c == 1 && d == 0) ? 1 :
            0;
    end 
    else begin
        q = (c == 0 && d == 0) ? 1 :
            (c == 0 && d == 1) ? 0 :
            (c == 1 && d == 0) ? 0 :
            1;
    end
end

endmodule
