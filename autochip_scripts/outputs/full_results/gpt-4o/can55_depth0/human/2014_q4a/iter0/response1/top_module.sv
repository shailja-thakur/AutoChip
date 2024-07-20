module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);
    
    always @(posedge clk) begin
        if (L) begin
            Q <= R;             // Load the value R into Q if L is asserted
        end 
        else if (E) begin
            Q <= w;             // If E is asserted, shift by loading w into Q
        end
    end

endmodule
