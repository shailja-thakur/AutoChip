module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    // State parameter declarations
    typedef enum logic [1:0] {
        S0 = 2'b00,
        S1 = 2'b01,
        S2 = 2'b10,
        S3 = 2'b11
    } state_t;

    state_t current_state, next_state;

    // Update the state on clock's positive edge or asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= S1;
        end else begin
            current_state <= next_state;
        end
    end

    // Determine the next state based on current state and inputs
    always_comb begin
        next_state = current_state;
        if (train_valid) begin
            case (current_state)
                S0: if (train_taken) next_state = S1;
                S1: if (train_taken) next_state = S2;
                    else next_state = S0;
                S2: if (train_taken) next_state = S3;
                    else next_state = S1;
                S3: if (!train_taken) next_state = S2;
            endcase
        end
    end

    // Output the current state
    assign state = current_state;

endmodule
