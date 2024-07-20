module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

always @(posedge clk) begin
    state <= q; // Observing the current state of q as the output state
    if (a == 1'b1 && b == 1'b1) begin
        q <= ~q; // Toggle q
    end else if (a == 1'b1 && b == 1'b0) begin
        q <= 1'b1; // Set q to 1
    end else if (a == 1'b0 && b == 1'b1) begin
        q <= 1'b0; // Set q to 0
    end
    // if a and b are both zero, retain the current state of q
end

endmodule
