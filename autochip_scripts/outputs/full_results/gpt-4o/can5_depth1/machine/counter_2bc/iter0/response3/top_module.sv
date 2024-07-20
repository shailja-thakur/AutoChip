module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

// State encoding
typedef enum logic [1:0] {
    STATE_0 = 2'b00,
    STATE_1 = 2'b01,
    STATE_2 = 2'b10,
    STATE_3 = 2'b11
} state_t;

state_t current_state, next_state;

// State transition logic
always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
        current_state <= STATE_1;
    end else begin
        current_state <= next_state;
    end
end

// Next state logic
always_comb begin
    next_state = current_state; // default state
    if (train_valid) begin
        case (current_state)
            STATE_0: next_state = (train_taken) ? STATE_1 : STATE_0;
            STATE_1: next_state = (train_taken) ? STATE_2 : STATE_0;
            STATE_2: next_state = (train_taken) ? STATE_3 : STATE_1;
            STATE_3: next_state = (train_taken) ? STATE_3 : STATE_2;
            default: next_state = STATE_1;
        endcase
    end
end

// Output assignment
assign state = current_state;

endmodule
