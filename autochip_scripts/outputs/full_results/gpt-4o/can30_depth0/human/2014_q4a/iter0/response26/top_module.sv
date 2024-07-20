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
            Q <= R; // Load value R when L is high
        end else if (E) begin
            Q <= w; // Shift the value when E is high
        end
    end

endmodule
