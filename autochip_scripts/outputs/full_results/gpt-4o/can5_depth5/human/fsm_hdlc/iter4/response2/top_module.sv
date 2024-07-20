module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    // State encoding
    typedef enum reg [3:0] {
        IDLE = 4'b0000,
        S0 = 4'b0001,  // 0
        S1 = 4'b0010,  // 01
        S2 = 4'b0011,  // 011
        S3 = 4'b0100,  // 0111
        S4 = 4'b0101,  // 01111
        S5 = 4'b0110,  // 011111
        S6 = 4'b0111,  // 0111111
        S7 = 4'b1000   // 01111111 or error
    } state_t;
    
    state_t current_state, next_state;

    // State transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    // Output logic
    always @(posedge clk) begin
        if (reset) begin
            disc <= 1'b0;
            flag <= 1'b0;
            err <= 1'b0;
        end else begin
            disc <= (next_state == S5 && current_state == S6 && !in);
            flag <= (next_state == S6 && current_state == S7 && !in);
            err <= (next_state == S7 && current_state == S7 && in);
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            IDLE: next_state = in ? S1 : S0;
            S0: next_state = in ? S1 : S0;
            S1: next_state = in ? S2 : IDLE;
            S2: next_state = in ? S3 : IDLE;
            S3: next_state = in ? S4 : IDLE;
            S4: next_state = in ? S5 : IDLE;
            S5: next_state = in ? S6 : IDLE;
            S6: next_state = in ? S7 : IDLE;
            S7: next_state = in ? S7 : IDLE; // Stay in error state if more 1s
            default: next_state = IDLE;
        endcase
    end
endmodule
