module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

always @(posedge clk) begin
    if (R) begin       // Reset has highest priority
        Q <= 1'b0;
    end else if (E) begin
        if (L) begin   // Load R if L is high
            Q <= 1'b0; // Assuming output Q is forced low when L and R are high
        end else begin // Load w if L is low
            Q <= w;
        end
    end
end

endmodule
