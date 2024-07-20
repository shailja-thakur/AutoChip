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
        Q <= 1'b0; // Reset the output Q to low if reset signal is high
    end else if (E) begin
        if (L) begin
            Q <= R; // When L is high, Q should be updated with the value of R
        end else begin
            Q <= w; // When L is low, Q should be updated with the value of w
        end
    end
end

endmodule
