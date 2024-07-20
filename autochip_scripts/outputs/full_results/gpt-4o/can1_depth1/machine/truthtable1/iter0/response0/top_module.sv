module top_module (
    input x3,
    input x2,
    input x1,
    output reg f
);

    always @(*) begin
        if ((!x3 && x2 && !x1) || (!x3 && x2 && x1) || (x3 && !x2 && x1) || (x3 && x2 && x1)) begin
            f = 1;
        end else begin
            f = 0;
        end
    end
    
endmodule
