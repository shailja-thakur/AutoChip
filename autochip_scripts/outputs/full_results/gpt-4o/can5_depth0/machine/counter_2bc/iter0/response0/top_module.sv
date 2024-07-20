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
            S0: begin
                if (train_valid) begin
                    if (train_taken)
                        next_state = S1;
                    else
                        next_state = S0;
                end
                else begin
                    next_state = S0;
                end
            end
            S1: begin
                if (train_valid) begin
                    if (train_taken)
                        next_state = S2;
                    else
                        next_state = S0;
                end
                else begin
                    next_state = S1;
                end
            end
            S2: begin
                if (train_valid) begin
                    if (train_taken)
                        next_state = S3;
                    else
                        next_state = S1;
                end
                else begin
                    next_state = S2;
                end
            end
            S3: begin
                if (train_valid) begin
                    if (train_taken)
                        next_state = S3;
                    else
                        next_state = S2;
                end
                else begin
                    next_state = S3;
                end
            end
            default: next_state = S1; // Default state
        endcase
    end

    // State flip-flops with asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= S1;
        else
            current_state <= next_state;
    end

    // Output logic
    assign state = current_state;

endmodule
