module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Declare internal signals
    logic [1:0] next_state;

    // Define state machine states
    parameter IDLE_STATE = 0;
    parameter NEXT_STATE = 1;
    parameter PREV_STATE = 2;
    parameter SAME_STATE = 3;

    // Flip-flop for the current state
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= IDLE_STATE;
        end else begin
            state <= next_state;
        end
    end

    // State transition logic
    always_comb begin
        // Default next state is the current state
        next_state = state;

        // State transitions based on inputs
        case (state)
            IDLE_STATE: begin
                if (train_valid) begin
                    if (train_taken) begin
                        next_state = NEXT_STATE;
                    end
                end
            end

            NEXT_STATE: begin
                if (!train_taken) begin
                    next_state = state - 1;
                end else if (state < SAME_STATE) begin
                    next_state = state + 1;
                end
            end

            PREV_STATE: begin
                if (train_taken) begin
                    if (state < SAME_STATE) begin
                        next_state = state + 1;
                    end
                end
            end

            SAME_STATE: begin
                if (!train_taken) begin
                    if (state > IDLE_STATE) begin
                        next_state = state - 1;
                    end
                end
            end
        endcase
    end

endmodule
