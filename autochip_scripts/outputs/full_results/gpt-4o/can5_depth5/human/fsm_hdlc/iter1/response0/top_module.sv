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
        S1 = 4'b0001,  // 0
        S2 = 4'b0010,  // 01
        S3 = 4'b0011,  // 011
        S4 = 4'b0100,  // 0111
        S5 = 4'b0101,  // 01111
        S6 = 4'b0110,  // 011111
        S7 = 4'b0111,  // 0111111
        ERROR = 4'b1000   // 01111111 or error
    } state_t;
    
    state_t current_state, next_state;

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= S_RESET;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        // Default outputs
        next_state = current_state;
        disc = 1'b0;
        flag = 1'b0;
        err = 1'b0;

        case (current_state)
            S_RESET: begin
                if (in) begin
                    next_state = S1;
                end else begin
                    next_state = S_RESET;
                end
            end
            S1: begin
                if (in) begin
                    next_state = S2;
                end else begin
                    next_state = S_RESET;
                end
            end
            S2: begin
                if (in) begin
                    next_state = S3;
                end else begin
                    next_state = S_RESET;
                end
            end
            S3: begin
                if (in) begin
                    next_state = S4;
                end else begin
                    next_state = S_RESET;
                end
            end
            S4: begin
                if (in) begin
                    next_state = S5;
                end else begin
                    next_state = S_RESET;
                end
            end
            S5: begin
                if (in) begin
                    next_state = S6;
                end else begin
                    next_state = S_RESET;
                    disc = 1'b1; // 0111110 detected
                end
            end
            S6: begin
                if (in) begin
                    next_state = S7;
                end else begin
                    next_state = S_RESET;
                    flag = 1'b1; // 01111110 detected
                end
            end
            S7: begin
                if (in) begin
                    next_state = ERROR; // 01111111... 7 or more 1s detected
                    err = 1'b1;
                end else begin
                    next_state = S_RESET;
                    flag = 1'b1; // 01111110 detected
                end
            end
            ERROR: begin
                if (!in) begin
                    next_state = S_RESET;
                end
            end
        endcase
    end
endmodule
