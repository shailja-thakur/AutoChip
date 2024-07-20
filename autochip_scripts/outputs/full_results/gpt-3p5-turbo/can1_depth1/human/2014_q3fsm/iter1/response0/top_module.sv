module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [1:0] state, next_state;

// Reset state
always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 2'b00; // State A
    else
        state <= next_state;
end

// Next state logic
always @(state, w) begin
    case (state)
        2'b00: begin // State A
            if (s == 1)
                next_state <= 2'b01; // State B
            else
                next_state <= 2'b00; // Stay in State A
        end
        2'b01: begin // State B
            if (w) begin
                case ({w, next_state[0]}) // Checking for exactly two 1s in the next three clock cycles
                    3'b010: next_state <= 2'b11; // Stay in State B
                    3'b011: next_state <= 2'b11; // Stay in State B
                    default: next_state <= 2'b10; // Go to State C
                endcase
            end else 
                next_state <= 2'b01; // Stay in State B
        end
        2'b10: begin // State C
            next_state <= 2'b00; // Go back to State A
        end
        2'b11: begin // State D
            next_state <= 2'b01; // Go back to State B
        end
    endcase
end

// Output logic
always @(posedge clk) begin
    case (state)
        2'b01, 2'b11: z <= (s==0) ? 0 : 1; // Set z to 1 in State B and State D if s is 1
        default: z <= 0; // Set z to 0 for all other states
    endcase
end

endmodule
