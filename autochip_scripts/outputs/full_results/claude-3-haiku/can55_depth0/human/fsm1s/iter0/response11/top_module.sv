module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

// Define the states
parameter A = 1'b0, B = 1'b1;

// Internal state
reg state;

always @(posedge clk) begin
    if (reset) begin
        // Reset state to B
        state <= B;
    end
    else begin
        case (state)
            B: begin
                out <= 1'b1;
                // If input is 0, go to state A
                // If input is 1, stay in state B
                state <= (in) ? B : A;
            end
            A: begin
                out <= 1'b0;
                // If input is 0, go to state B
                // If input is 1, stay in state A
                state <= (in) ? A : B;
            end
            default: begin
                // Invalid state, go to state B
                state <= B;
            end
        endcase
    end
end

endmodule
