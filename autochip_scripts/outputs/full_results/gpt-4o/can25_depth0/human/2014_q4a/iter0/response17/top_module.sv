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
            Q <= R;         // Load the value R into the register when L is asserted
        end else if (E) begin
            Q <= w;         // Shift the value w into the register when E is asserted
        end
    end

endmodule
