module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    typedef enum logic [1:0] {
        STATE_0 = 2'b00,
        STATE_1 = 2'b01,
        STATE_2 = 2'b10,
        STATE_3 = 2'b11
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= STATE_1;
        else if (train_valid)
            current_state <= next_state;
    end

    always_comb begin
        next_state = current_state;
        case (current_state)
            STATE_0: begin
                if (train_taken)
                    next_state = STATE_1;
            end
            STATE_1: begin
                if (train_taken)
                    next_state = STATE_2;
                else
                    next_state = STATE_0;
            end
            STATE_2: begin
                if (train_taken)
                    next_state = STATE_3;
                else
                    next_state = STATE_1;
            end
            STATE_3: begin
                if (!train_taken)
                    next_state = STATE_2;
            end
        endcase
    end

    assign state = current_state;

endmodule
