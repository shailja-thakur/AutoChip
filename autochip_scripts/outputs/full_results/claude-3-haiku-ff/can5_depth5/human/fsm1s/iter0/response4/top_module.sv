module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

// Define the state variables
reg state_A, state_B;

// Reset the state machine to state B on active-high synchronous reset
always @(posedge clk) begin
    if (reset) begin
        state_A <= 0;
        state_B <= 1;
    end
    else begin
        case ({state_A, state_B})
            2'b10: // State A
                if (in) begin
                    state_A <= 1;
                    state_B <= 0;
                end
                else begin
                    state_A <= 0;
                    state_B <= 1;
                end
            2'b01: // State B
                if (in) begin
                    state_A <= 0;
                    state_B <= 1;
                end
                else begin
                    state_A <= 1;
                    state_B <= 0;
                end
            default: // Invalid state, go to state B
                state_A <= 0;
                state_B <= 1;
        endcase
    end
end

// Output logic
always @(*) begin
    if (state_B) begin
        out = 1;
    end
    else begin
        out = 0;
    end
end

endmodule
