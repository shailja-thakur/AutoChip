module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);
    // State enumeration
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        BYTE1 = 2'b01,
        BYTE2 = 2'b10,
        BYTE3 = 2'b11
    } state_t;

    state_t current_state, next_state;

    // State Register
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            done <= 0;  // Make sure done is de-asserted on reset
        end
        else begin
            current_state <= next_state;
            if (current_state == BYTE3) begin
                done <= 1;  // Signal done at BYTE3
            end
            else begin
                done <= 0;  // Otherwise clear done
            end
        end
    end

    // Next State Logic
    always_comb begin
        case (current_state)
            IDLE: begin
                if (in[3] == 1) begin
                    next_state = BYTE1;
                end
                else begin
                    next_state = IDLE;
                end
            end
            BYTE1: begin
                next_state = BYTE2;
            end
            BYTE2: begin
                next_state = BYTE3;
            end
            BYTE3: begin
                if (in[3] == 1) begin
                    next_state = BYTE1;
                end
                else begin
                    next_state = IDLE;
                end
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end
endmodule
