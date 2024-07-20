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
        Q <= 1'b0; // Reset the register to known state
    end else if (E) begin
        if (L) begin
            Q <= R; // Loading value of R into register
        end else begin
            Q <= w; // Loading value of w into register
        end
    end
end

endmodule
