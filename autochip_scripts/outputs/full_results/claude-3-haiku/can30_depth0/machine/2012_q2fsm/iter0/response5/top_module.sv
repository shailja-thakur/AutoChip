module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    // Define the state register and its initial value
    reg [2:0] state;
    initial begin
        state = 3'b000; // State A
    end

    // Define the state transitions
    always @(posedge clk) begin
        if (reset) begin
            state <= 3'b000; // Reset to state A
        end
        else begin
            case (state)
                3'b000: // State A
                    if (w == 1'b0)
                        state <= 3'b000; // Stay in state A
                    else
                        state <= 3'b001; // Transition to state B
                3'b001: // State B
                    if (w == 1'b0)
                        state <= 3'b011; // Transition to state D
                    else
                        state <= 3'b010; // Transition to state C
                3'b010: // State C
                    if (w == 1'b0)
                        state <= 3'b011; // Transition to state D
                    else
                        state <= 3'b100; // Transition to state E
                3'b011: // State D
                    if (w == 1'b0)
                        state <= 3'b000; // Transition to state A
                    else
                        state <= 3'b101; // Transition to state F
                3'b100: // State E
                    if (w == 1'b0)
                        state <= 3'b011; // Transition to state D
                    else
                        state <= 3'b100; // Stay in state E
                3'b101: // State F
                    if (w == 1'b0)
                        state <= 3'b011; // Transition to state D
                    else
                        state <= 3'b010; // Transition to state C
            endcase
        end
    end

    // Define the output logic
    always @(*) begin
        if (state == 3'b100 || state == 3'b101) // State E or F
            z = 1'b1;
        else
            z = 1'b0;
    end

endmodule
