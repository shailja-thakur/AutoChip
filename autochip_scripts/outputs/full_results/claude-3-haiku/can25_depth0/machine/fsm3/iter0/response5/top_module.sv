module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // Define the state register
    reg [1:0] state;
    
    // Define the state transitions
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b00; // Reset to state A
        end
        else begin
            case (state)
                2'b00: // State A
                    if (in) begin
                        state <= 2'b01; // Transition to state B
                    end
                    else begin
                        state <= 2'b00; // Stay in state A
                    end
                2'b01: // State B
                    if (in) begin
                        state <= 2'b01; // Stay in state B
                    end
                    else begin
                        state <= 2'b10; // Transition to state C
                    end
                2'b10: // State C
                    if (in) begin
                        state <= 2'b11; // Transition to state D
                    end
                    else begin
                        state <= 2'b00; // Transition to state A
                    end
                2'b11: // State D
                    if (in) begin
                        state <= 2'b01; // Transition to state B
                    end
                    else begin
                        state <= 2'b10; // Transition to state C
                    end
            endcase
        end
    end
    
    // Set the output signal
    always @(*) begin
        if (state == 2'b11) begin
            out = 1'b1; // Output is high when in state D
        end
        else begin
            out = 1'b0;
        end
    end

endmodule
