module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

always @(posedge clk) begin
    if (R)
        Q <= 1'b0;  // Reset the register to a known state when R is high.
    else if (E) begin  // Only update the register if enable (E) is high.
        if (L)
            Q <= R;  // Load R into the register if L is high.
        else
            Q <= w;  // Load w into the register if L is low.
    end
end

endmodule
