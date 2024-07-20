module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

reg [2:0] state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 3'b000; // Set initial state to A
        z <= 0; // Reset z output
    end else begin
        case (state)
            3'b000: // State A
                if (w) begin
                    state <= 3'b001; // Transition to state B
                    z <= 0; // Reset z output
                end else begin
                    state <= 3'b000; // Stay in state A
                    z <= 0; // Reset z output
                end
            3'b001: // State B
                if (w) begin
                    state <= 3'b010; // Transition to state C
                    z <= 0; // Reset z output
                end else begin
                    state <= 3'b100; // Transition to state D
                    z <= 0; // Reset z output
                end
            3'b010: // State C
                if (w) begin
                    state <= 3'b101; // Transition to state E
                    z <= 0; // Reset z output
                end else begin
                    state <= 3'b100; // Transition to state D
                    z <= 0; // Reset z output
                end
            3'b100: // State D
                if (w) begin
                    state <= 3'b111; // Transition to state F
                    z <= 0; // Reset z output
                end else begin
                    state <= 3'b000; // Transition to state A
                    z <= 0; // Reset z output
                end
            3'b101: // State E
                if (w) begin
                    state <= 3'b101; // Stay in state E
                    z <= 1; // Set z output to 1
                end else begin
                    state <= 3'b100; // Transition to state D
                    z <= 0; // Reset z output
                end
            3'b111: // State F
                if (w) begin
                    state <= 3'b011; // Transition to state C
                    z <= 0; // Reset z output
                end else begin
                    state <= 3'b100; // Transition to state D
                    z <= 1; // Set z output to 1
                end
        endcase
    end
end

endmodule
