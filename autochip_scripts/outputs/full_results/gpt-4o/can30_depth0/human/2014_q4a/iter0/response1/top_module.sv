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
            Q <= R; // Load value R into the register
        end else if (E) begin
            Q <= w; // Shift value w into the register
        end
        // If neither L nor E is asserted, Q holds its value
    end
    
endmodule
