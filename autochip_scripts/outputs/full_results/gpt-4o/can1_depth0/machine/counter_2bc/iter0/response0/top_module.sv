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
    always_comb begin
        case (current_state)
            S0: next_state = (train_valid && train_taken) ? S1 : S0;
            S1: next_state = (train_valid && train_taken) ? S2 :
                             (train_valid && !train_taken) ? S0 : S1;
            S2: next_state = (train_valid && train_taken) ? S3 :
                             (train_valid && !train_taken) ? S1 : S2;
            S3: next_state = (train_valid && !train_taken) ? S2 : S3;
            default: next_state = S1;
        endcase
    end
    
    // State register
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= S1;
        else
            current_state <= next_state;
    end
    
    // Output logic
    assign state = current_state;

endmodule
