module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    // State declarations
    typedef enum reg [1:0] {
        IDLE = 2'b00,
        S1 = 2'b01,
        S2 = 2'b10,
        S3 = 2'b11
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            start_shifting <= 0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic and output logic
    always @(*) begin
        next_state = current_state; // Default to the current state
        case (current_state)
            IDLE: begin
                if (data) next_state = S1;
            end
            S1: begin
                if (data) next_state = S2;
                else next_state = IDLE;
            end
            S2: begin
                if (data) next_state = S2;
                else next_state = S3;
            end
            S3: begin
                if (data) next_state = S1;
                else begin
                    next_state = IDLE;
                    start_shifting = 1;
                end
            end
        endcase

        if (start_shifting)
            start_shifting = 1; // Once start_shifting is set, it remains 1
        else
            if (current_state == S3 && data == 1'b1)
                start_shifting = 1;
            else
                start_shifting = 0;
    end

endmodule
