module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Define states
    typedef enum logic [1:0] {STATE0, STATE1, STATE2, STATE3} states;
    states current_state, next_state;

    // Flip-flops for state machine
    always_ff @(posedge clk or negedge areset) begin
        if (areset == 0) begin
            current_state <= STATE1; // Reset to state 1
        end else begin
            current_state <= next_state;
        end
    end

    // Output logic for state machine
    always_comb begin
        case (current_state)
            STATE0: state <= 2'b00;
            STATE1: state <= 2'b01;
            STATE2: state <= 2'b10;
            STATE3: state <= 2'b11;
        endcase
    end

    // State transitions based on inputs
    always_comb begin
        next_state = current_state;
        if (train_valid) begin
            case (current_state)
                STATE0: next_state = (train_taken) ? STATE1 : STATE0;
                STATE1: next_state = (train_taken) ? STATE2 : STATE0;
                STATE2: next_state = (train_taken) ? STATE3 : STATE1;
                STATE3: next_state = (train_taken) ? STATE3 : STATE2;
            endcase
        end
    end

endmodule
