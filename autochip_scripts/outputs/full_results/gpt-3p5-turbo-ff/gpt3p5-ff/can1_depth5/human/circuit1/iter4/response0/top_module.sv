module top_module (
    input a, 
    input b, 
    output reg q
);
    
    always @(*) begin
        if (a & !b)
            q = 1'b1;
        else
            q = 1'b0;
    end
    
endmodule
