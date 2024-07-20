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
            Q <= R;  // This should actually be Q <= 1'b0 as L forces the reset state
        end else begin
            Q <= w;
        end
    end
end

endmodule
