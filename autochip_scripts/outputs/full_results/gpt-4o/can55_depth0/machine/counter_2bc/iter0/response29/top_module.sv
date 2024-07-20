module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // State encoding
    typedef enum logic [1:0] {
        STATE0 = 2'b00,
        STATE1 = 2'b01,
        STATE2 = 2'b10,
        STATE3 = 2'b11
    } state_t;

    state_t current_state, next_state;

    // Asynchronous reset (active-high)
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= STATE1;
        else
            current_state <= next_state;
    end

    // Next state logic
    always_comb begin
        next_state = current_state; // Default to no state change
        if (train_valid) begin
            case (current_state)
                STATE0: if (train_taken) next_state = STATE1;
                STATE1: if (train_taken) next_state = STATE2; else next_state = STATE0;
                STATE2: if (train_taken) next_state = STATE3; else next_state = STATE1;
                STATE3: if (!train_taken) next_state = STATE2;
                default: next_state = STATE1; // Default state should never be hit
            endcase
        end
    end

    // Output state assignment
    assign state = current_state;

endmodule
