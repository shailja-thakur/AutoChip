module top_module(
    input x,
    input y,
    output z
);
    
    always @(*) begin
        if (x && y)
            z = 1'b1;
        else
            z = 1'b0;
    end

endmodule
