module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);

    // Define states
    typedef enum logic [1:0] {
        STATE_0 = 2'b00,
        STATE_1 = 2'b01,
        STATE_2 = 2'b10,
        STATE_3 = 2'b11
    } state_t;

    state_t next_state;

    // State transition logic
    always @(*) begin
        case (state)
            STATE_0: begin
                if (train_valid && train_taken)
                    next_state = STATE_1;
                else
                    next_state = STATE_0;
            end
            STATE_1: begin
                if (train_valid && train_taken)
                    next_state = STATE_2;
                else if (train_valid && !train_taken)
                    next_state = STATE_0;
                else
                    next_state = STATE_1;
            end
            STATE_2: begin
                if (train_valid && train_taken)
                    next_state = STATE_3;
                else if (train_valid && !train_taken)
                    next_state = STATE_1;
                else
                    next_state = STATE_2;
            end
            STATE_3: begin
                if (train_valid && !train_taken)
                    next_state = STATE_2;
                else
                    next_state = STATE_3;
            end
            default: next_state = STATE_1;  // Default to STATE_1 in case of any undefined states
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= STATE_1;
        else
            state <= next_state;
    end

endmodule
