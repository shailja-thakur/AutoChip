module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);
    
    always @(posedge clk) begin
        if (E) begin
            if (R) 
                Q <= 0;
            else if (L)
                Q <= R;
            else
                Q <= w;
        end
    end
    
endmodule
