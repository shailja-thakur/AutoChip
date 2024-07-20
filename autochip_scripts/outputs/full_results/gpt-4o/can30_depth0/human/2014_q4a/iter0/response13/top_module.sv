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
            Q <= R;       // Load value R into Q
        end
        else if (E) begin
            Q <= w;       // Shift operation, load w into Q
        end
        // If neither L nor E is asserted, Q remains unchanged
    end

endmodule
