module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

reg [2:0] state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 3'b000; // Initialize state to A
    end
    else begin
        case (state)
            3'b000: // State A
                if (x) begin
                    state <= 3'b001; // Transition to state B
                end
                else begin
                    state <= 3'b000; // Remain in state A
                end
            3'b001: // State B
                if (x) begin
                    state <= 3'b100; // Transition to state E
                end
                else begin
                    state <= 3'b001; // Remain in state B
                end
            3'b010: // State C
                if (x) begin
                    state <= 3'b001; // Transition to state B
                end
                else begin
                    state <= 3'b010; // Remain in state C
                end
            3'b011: // State D
                if (x) begin
                    state <= 3'b010; // Transition to state C
                end
                else begin
                    state <= 3'b001; // Transition to state B
                end
            3'b100: // State E
                if (x) begin
                    state <= 3'b100; // Remain in state E
                end
                else begin
                    state <= 3'b011; // Transition to state D
                end
            default:
                state <= 3'b000; // Reset to state A
        endcase
    end
end

// Assign the output based on the current state
assign z = (state == 3'b011 || state == 3'b100); // Output is high when in state D or E

endmodule
