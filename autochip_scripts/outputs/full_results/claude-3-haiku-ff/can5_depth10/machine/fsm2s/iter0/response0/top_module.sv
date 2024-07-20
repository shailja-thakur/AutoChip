module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

reg state; // 0 for state A, 1 for state B

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 0; // Reset to state A
    end
    else begin
        case (state)
            0: begin // State A
                if (j) begin
                    state <= 1; // Transition to state B
                end
                else begin
                    state <= 0; // Remain in state A
                end
            end
            1: begin // State B
                if (k) begin
                    state <= 0; // Transition to state A
                end
                else begin
                    state <= 1; // Remain in state B
                end
            end
        endcase
    end
end

always @(*) begin
    out = (state == 1); // Output is high when in state B
end

endmodule
