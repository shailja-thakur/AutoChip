module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

always @(posedge clk or posedge R) begin
    if (R) begin
        Q <= 1'b0;
    end else if (E) begin
        if (L) begin
            Q <= 1'b0;  // Q should be reset to 0 when L is high, as R is already considered in the outer condition
        end else begin
            Q <= w;
        end
    end
end

endmodule
