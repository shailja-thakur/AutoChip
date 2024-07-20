module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);
    // State Encoding
    typedef enum reg [2:0] {
        IDLE = 3'b000,
        S1 = 3'b001, // first 1
        S2 = 3'b010, // second 1
        S3 = 3'b011, // 0 after two 1's
        S4 = 3'b100  // detecting the final 1 of 1101
    } state_t;

    state_t state, next_state;

    // State Transition
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Next State Logic
    always @(*) begin
        case (state)
            IDLE: next_state = data ? S1 : IDLE;
            S1: next_state = data ? S2 : IDLE;
            S2: next_state = data ? S2 : S3;
            S3: next_state = data ? S4 : IDLE;
            S4: next_state = S4;
            default: next_state = IDLE;
        endcase
    end

    // Output Logic
    always @(posedge clk) begin
        if (reset) begin
            start_shifting <= 0;
        end else begin
            if (state == S4) begin
                start_shifting <= 1;
            end
        end
    end

endmodule
