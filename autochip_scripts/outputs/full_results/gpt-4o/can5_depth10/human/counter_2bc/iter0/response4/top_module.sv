module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // State definitions
    typedef enum logic [1:0] {
        WT = 2'b01,  // Weakly not-taken
        ST = 2'b11,  // Strongly taken
        WN = 2'b00,  // Weakly taken
        SN = 2'b10   // Strongly not-taken
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always_comb begin
        case(current_state)
            ST: begin
                if (train_valid) begin
                    if (train_taken)
                        next_state = ST;
                    else
                        next_state = WT;
                end else begin
                    next_state = ST;
                end
            end
            WT: begin
                if (train_valid) begin
                    if (train_taken)
                        next_state = ST;
                    else
                        next_state = WN;
                end else begin
                    next_state = WT;
                end
            end
            WN: begin
                if (train_valid) begin
                    if (train_taken)
                        next_state = WT;
                    else
                        next_state = SN;
                end else begin
                    next_state = WN;
                end
            end
            SN: begin
                if (train_valid) begin
                    if (train_taken)
                        next_state = WN;
                    else
                        next_state = SN;
                end else begin
                    next_state = SN;
                end
            end
            default: next_state = WT;
        endcase
    end

    // State flip-flops with asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= WT;
        else
            current_state <= next_state;
    end

    // Output assignment
    assign state = current_state;

endmodule
