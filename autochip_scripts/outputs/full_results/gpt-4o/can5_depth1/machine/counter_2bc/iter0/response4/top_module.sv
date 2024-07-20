module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    typedef enum logic [1:0] {
        S0 = 2'b00,
        S1 = 2'b01,
        S2 = 2'b10,
        S3 = 2'b11
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= S1;
        end else if (train_valid) begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            S0: next_state = (train_taken) ? S1 : S0;
            S1: next_state = (train_taken) ? S2 : S0;
            S2: next_state = (train_taken) ? S3 : S1;
            S3: next_state = (train_taken) ? S3 : S2;
            default: next_state = S1;
        endcase
    end

    // Output assignment
    assign state = current_state;

endmodule
