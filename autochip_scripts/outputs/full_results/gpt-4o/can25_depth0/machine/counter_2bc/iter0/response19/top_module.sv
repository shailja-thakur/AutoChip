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
    always @(*) begin
        case (current_state)
            S0: if (train_valid)
                    next_state = train_taken ? S1 : S0;
                else
                    next_state = S0;
            S1: if (train_valid)
                    next_state = train_taken ? S2 : S0;
                else
                    next_state = S1;
            S2: if (train_valid)
                    next_state = train_taken ? S3 : S1;
                else
                    next_state = S2;
            S3: if (train_valid)
                    next_state = train_taken ? S3 : S2;
                else
                    next_state = S3;
            default: next_state = S1;
        endcase
    end

    // State register
    always @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= S1;
        else
            current_state <= next_state;
    end

    // Output logic
    assign state = current_state;

endmodule
