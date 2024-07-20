module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

// Define the states
localparam STATE_A = 1'b0;
localparam STATE_B = 1'b1;

// Current state register
reg state_reg;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        // Reset the state to B
        state_reg <= STATE_B;
        out <= 1'b1;
    end
    else begin
        case (state_reg)
            STATE_A: begin
                if (in) begin
                    // Transition from A to A
                    state_reg <= STATE_A;
                    out <= 1'b0;
                end
                else begin
                    // Transition from A to B
                    state_reg <= STATE_B;
                    out <= 1'b1;
                end
            end
            STATE_B: begin
                if (in) begin
                    // Transition from B to B
                    state_reg <= STATE_B;
                    out <= 1'b1;
                end
                else begin
                    // Transition from B to A
                    state_reg <= STATE_A;
                    out <= 1'b0;
                end
            end
        endcase
    end
end

endmodule
