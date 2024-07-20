module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

// Define the states
localparam STATE_A = 1'b0;
localparam STATE_B = 1'b1;

// Register to store the current state
reg state_reg, state_next;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state_reg <= STATE_B;
    end else begin
        state_reg <= state_next;
    end
end

always @(*) begin
    // Next state logic
    case (state_reg)
        STATE_A: begin
            if (in) begin
                state_next = STATE_A;
            end else begin
                state_next = STATE_B;
            end
        end
        STATE_B: begin
            if (in) begin
                state_next = STATE_B;
            end else begin
                state_next = STATE_A;
            end
        end
        default: begin
            state_next = STATE_B;
        end
    endcase

    // Output logic
    if (state_reg == STATE_A) begin
        out = 1'b0;
    end else begin
        out = 1'b1;
    end
end

endmodule
