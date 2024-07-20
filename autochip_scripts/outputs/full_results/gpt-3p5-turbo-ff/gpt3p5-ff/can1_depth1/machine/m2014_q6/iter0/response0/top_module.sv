module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

reg [2:0] state; // Define a 3-bit state register

always @(posedge clk) begin
    if (reset) begin
        state <= 3'b000; // Reset the state to A when reset is high
    end else begin
        case (state)
            3'b000: begin // State A
                if (w) begin
                    state <= 3'b000; // Remain in state A when w is high
                end else begin
                    state <= 3'b001; // Transition to state B when w is low
                end
            end
            3'b001: begin // State B
                if (w) begin
                    state <= 3'b011; // Transition to state D when w is high
                end else begin
                    state <= 3'b010; // Transition to state C when w is low
                end
            end
            3'b010: begin // State C
                if (w) begin
                    state <= 3'b011; // Transition to state D when w is high
                end else begin
                    state <= 3'b100; // Transition to state E when w is low
                end
            end
            3'b011: begin // State D
                if (w) begin
                    state <= 3'b000; // Transition to state A when w is high
                end else begin
                    state <= 3'b101; // Transition to state F when w is low
                end
            end
            3'b100: begin // State E
                if (w) begin
                    state <= 3'b011; // Transition to state D when w is high
                end else begin
                    state <= 3'b100; // Remain in state E when w is low
                end
            end
            3'b101: begin // State F
                if (w) begin
                    state <= 3'b011; // Transition to state D when w is high
                end else begin
                    state <= 3'b010; // Transition to state C when w is low
                end
            end
        endcase
    end
end

always @(state) begin
    if (state == 3'b100 || state == 3'b101) begin // When in state E or F
        z <= 1'b1; // Set output z high
    end else begin
        z <= 1'b0; // Set output z low otherwise
    end
end

endmodule
