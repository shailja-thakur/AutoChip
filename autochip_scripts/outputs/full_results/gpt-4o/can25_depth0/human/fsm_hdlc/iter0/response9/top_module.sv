module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    // State encoding
    typedef enum reg [3:0] {
        S_RESET = 4'b0000,
        S_0 = 4'b0001,
        S_01 = 4'b0010,
        S_011 = 4'b0011,
        S_0111 = 4'b0100,
        S_01111 = 4'b0101,
        S_011111 = 4'b0110,
        S_0111111 = 4'b0111,
        S_01111110 = 4'b1000,
        S_01111111 = 4'b1001
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        // Default next state
        next_state = current_state;
        disc = 0;
        flag = 0;
        err = 0;

        case (current_state)
            S_RESET: next_state = in ? S_0 : S_RESET;
            S_0: next_state = in ? S_01 : S_RESET;
            S_01: next_state = in ? S_011 : S_RESET;
            S_011: next_state = in ? S_0111 : S_RESET;
            S_0111: next_state = in ? S_01111 : S_RESET;
            S_01111: next_state = in ? S_011111 : S_RESET;
            S_011111: begin
                if (in) next_state = S_0111111;
                else begin
                    next_state = S_0;
                    disc = 1;
                end
            end
            S_0111111: begin
                if (in) begin
                    next_state = S_01111111;
                    err = 1;
                end
                else begin
                    next_state = S_01111110;
                    flag = 1;
                end
            end
            S_01111110: next_state = in ? S_0 : S_RESET;
            S_01111111: next_state = in ? S_01111111 : S_RESET;
        endcase
    end

    // State register
    always @(posedge clk) begin
        if (reset) current_state <= S_RESET;
        else current_state <= next_state;
    end
endmodule
