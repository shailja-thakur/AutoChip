module top_module (
    input a, 
    input b, 
    output reg q
);
    
    always @(a, b) begin
        if (a & !b)
            q <= 1;
        else
            q <= 0;
    end
    
endmodule
