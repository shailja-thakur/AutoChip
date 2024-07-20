module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

always @(posedge clk) begin
    if (R) begin
        Q <= 1'b0; // Reset the output to 0 when R is high
    end
    else if (E) begin
        if (L) begin
            Q <= R; // Update output with R when L is high
        end else begin
            Q <= w; // Update output with w when L is low
        end
    end
end

endmodule
