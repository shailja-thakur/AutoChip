module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // Define state encoding
    typedef enum logic [1:0] {
        STATE_B = 2'b01,
        STATE_A = 2'b00
    } state_t;

    state_t current_state, next_state;

    // Sequential logic: State transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_B;
        end else begin
            current_state <= next_state;
        end
    end

    // Combinational logic: State transition and output logic
    always @(*) begin
        // Default assignments
        next_state = current_state;
        out = 1'b1; // Default output is 1 (for state B)

        case (current_state)
            STATE_B: begin
                if (in == 1'b0) begin
                    next_state = STATE_A;
                end else begin
                    next_state = STATE_B;
                end
                out = 1'b1; // Output for state B
            end
            STATE_A: begin
                if (in == 1'b0) begin
                    next_state = STATE_B;
                end else begin
                    next_state = STATE_A;
                end
                out = 1'b0; // Output for state A
            end
            default: begin
                next_state = STATE_B; // Default to state B in case of invalid state
            end
        endcase
    end

endmodule
