module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // State encoding
    typedef enum logic [1:0] {
        STATE_B = 2'b00,
        STATE_A = 2'b01
    } state_t;

    // State variables
    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            STATE_B: begin
                if (in == 1) begin
                    next_state = STATE_B;
                end else begin
                    next_state = STATE_A;
                end
            end
            STATE_A: begin
                if (in == 1) begin
                    next_state = STATE_A;
                end else begin
                    next_state = STATE_B;
                end
            end
            default: next_state = STATE_B;
        endcase
    end

    // State register with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= STATE_B;
        end else begin
            current_state <= next_state;
        end
    end

    // Output logic
    always @(*) begin
        case (current_state)
            STATE_B: out = 1;
            STATE_A: out = 0;
            default: out = 1; // Default case, although should never happen
        endcase
    end

endmodule
