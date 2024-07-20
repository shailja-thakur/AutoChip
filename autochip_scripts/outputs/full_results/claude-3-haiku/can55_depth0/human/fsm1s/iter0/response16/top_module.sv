module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

// Define the states
parameter A = 1'b0;
parameter B = 1'b1;

// Internal state register
reg state;

always @(posedge clk) begin
    if (reset) begin
        // Reset state to B
        state <= B;
        out <= 1'b1;
    end
    else begin
        case (state)
            B: begin
                if (in == 1'b0) begin
                    // Transition from B to A
                    state <= A;
                    out <= 1'b1;
                end
                else begin
                    // Remain in state B
                    state <= B;
                    out <= 1'b1;
                end
            end
            A: begin
                if (in == 1'b0) begin
                    // Transition from A to B
                    state <= B;
                    out <= 1'b0;
                end
                else begin
                    // Remain in state A
                    state <= A;
                    out <= 1'b0;
                end
            end
            default: begin
                // Invalid state, reset to B
                state <= B;
                out <= 1'b1;
            end
        endcase
    end
end

endmodule
