module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [1:0] state; // 2 bits to represent 3 states

always @(posedge clk) begin
    if (reset) begin
        state <= 0; // Reset to state A
        z <= 0;
    end
    else begin
        case (state)
            0: // State A
                if (s) begin
                    state <= 1; // Transition to state B
                end
            1: // State B
                if (w) begin
                    state <= 2; // Transition to state C
                end
                else begin
                    state <= 0; // Transition back to state A
                end
            2: // State C
                if (w) begin
                    state <= 3; // Transition to state D
                    z <= 1; // Set output z to 1
                end
                else begin
                    state <= 0; // Transition back to state A
                    z <= 0; // Set output z to 0
                end
            3: // State D
                if (w) begin
                    state <= 2; // Transition back to state C
                    z <= 0; // Set output z to 0
                end
                else begin
                    state <= 0; // Transition back to state A
                    z <= 0; // Set output z to 0
                end
        endcase
    end
end

endmodule
