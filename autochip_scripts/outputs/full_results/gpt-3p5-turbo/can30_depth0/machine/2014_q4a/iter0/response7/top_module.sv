module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

always @(posedge clk) begin
    if (E == 0) begin
        Q <= Q;  // Output Q is held in its current state
    end else if (L == 1) begin
        Q <= R;  // Output Q is updated with the value of R
    end else begin
        Q <= w;  // Output Q is updated with the value of w
    end
end

endmodule
