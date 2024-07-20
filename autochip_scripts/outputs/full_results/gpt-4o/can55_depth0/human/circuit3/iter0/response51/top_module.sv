module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output reg q
);
    always @(*) begin
        if (b && (c || d)) begin
            q = 1;
        end else if (a && d) begin
            q = 1;
        end else begin
            q = 0;
        end
    end
endmodule
