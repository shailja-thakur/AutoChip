module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01
    } state_t;

    state_t state, next_state;

    // State transition
    always @(*) begin
        case (state)
            STATE_A: begin
                if (in) begin
                    next_state = STATE_A;
                end else begin
                    next_state = STATE_B;
                end
            end

            STATE_B: begin
                if (in) begin
                    next_state = STATE_B;
                end else begin
                    next_state = STATE_A;
                end
            end

            default: next_state = STATE_B; // Default to state B if somehow in undefined state
        endcase
    end

    // Sequential logic for state progression and reset handling
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_B;
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    always @(*) begin
        case (state)
            STATE_A: out = 1'b0;
            STATE_B: out = 1'b1;
            default: out = 1'b1;
        endcase
    end

endmodule
