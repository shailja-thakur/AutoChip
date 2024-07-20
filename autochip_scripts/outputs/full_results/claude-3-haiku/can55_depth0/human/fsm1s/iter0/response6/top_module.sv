module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

// Define the states
localparam STATE_B = 1'b0;
localparam STATE_A = 1'b1;

// Define the state register
reg state;

always @(posedge clk) begin
    if (reset) begin
        // Reset the state to B
        state <= STATE_B;
    end
    else begin
        case (state)
            STATE_B: begin
                out <= 1'b1;
                if (in) begin
                    state <= STATE_B;
                end
                else begin
                    state <= STATE_A;
                end
            end
            STATE_A: begin
                out <= 1'b0;
                if (in) begin
                    state <= STATE_A;
                end
                else begin
                    state <= STATE_B;
                end
            end
            default: begin
                // Undefined state, reset to B
                state <= STATE_B;
            end
        endcase
    end
end

endmodule
