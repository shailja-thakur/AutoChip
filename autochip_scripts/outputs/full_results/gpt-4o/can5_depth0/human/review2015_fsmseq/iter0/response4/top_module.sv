module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    // State encoding
    typedef enum reg [2:0] {
        S0 = 3'b000, // Initial state
        S1 = 3'b001, // First '1' detected
        S2 = 3'b010, // '1' followed by '1'
        S3 = 3'b011, // '11' followed by '0'
        S4 = 3'b100  // '110' followed by '1'
    } state_t;

    // State register
    state_t state, next_state;

    // Synchronous state transition
    always @(posedge clk) begin
        if (reset) begin
            state <= S0;
            start_shifting <= 0;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic and output logic
    always @(*) begin
        next_state = state; // Default: remain in the same state
        case (state)
            S0: begin
                if (data) next_state = S1;
            end
            S1: begin
                if (data) next_state = S2;
                else next_state = S0;
            end
            S2: begin
                if (!data) next_state = S3;
            end
            S3: begin
                if (data) next_state = S4;
                else next_state = S0;
            end
            S4: begin
                start_shifting = 1;
                if (reset) next_state = S0;
                else next_state = S4; // Stay in S4 indefinitely unless reset
            end
        endcase
    end
endmodule
