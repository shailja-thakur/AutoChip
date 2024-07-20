module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

// Define the states
localparam STATE_A = 1'b0;
localparam STATE_B = 1'b1;

// Internal reg to store the current state
reg state_reg, state_next;

always @(posedge clk) begin
    if (reset) begin
        state_reg <= STATE_B;
    end
    else begin
        state_reg <= state_next;
    end
end

always @(*) begin
    // Default output
    out = 1'b0;

    // Next state logic
    case (state_reg)
        STATE_A: begin
            if (in == 1'b0) begin
                state_next = STATE_B;
                out = 1'b0;
            end
            else begin
                state_next = STATE_A;
                out = 1'b0;
            end
        end
        STATE_B: begin
            if (in == 1'b0) begin
                state_next = STATE_B;
                out = 1'b1;
            end
            else begin
                state_next = STATE_B;
                out = 1'b1;
            end
        end
        default: begin
            state_next = STATE_B;
            out = 1'b0;
        end
    endcase
end

endmodule
