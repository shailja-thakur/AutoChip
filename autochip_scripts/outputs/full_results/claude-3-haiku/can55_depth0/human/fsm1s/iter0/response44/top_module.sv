module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

// Define the states
parameter A = 1'b0, B = 1'b1;

// State register
reg state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= B; // Reset to state B
    end
    else begin
        case (state)
            B: begin
                out <= 1'b1; // Output is 1 in state B
                if (in) begin
                    state <= B; // Stay in state B if input is 1
                end
                else begin
                    state <= A; // Transition to state A if input is 0
                end
            end
            A: begin
                out <= 1'b0; // Output is 0 in state A
                if (in) begin
                    state <= A; // Stay in state A if input is 1
                end
                else begin
                    state <= B; // Transition to state B if input is 0
                end
            end
        endcase
    end
end

endmodule
