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
        Q <= 1'b0;          // Reset Q to 0 when R is high
    else if (E) begin       // Check if enable is high
        if (L) 
            Q <= R;         // Load R into Q when L is high
        else 
            Q <= w;         // Load w into Q when L is low
    end
    // If E is low, Q remains unchanged, no need to explicitly code this.
end

endmodule
