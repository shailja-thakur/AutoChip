module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    // State declaration
    typedef enum logic [1:0] {
        IDLE    = 2'b00,
        BYTE1   = 2'b01,
        BYTE2   = 2'b10,
        BYTE3   = 2'b11
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (in[3] == 1'b1) begin
                    next_state = BYTE1;
                end else begin
                    next_state = IDLE;
                end
            end
            BYTE1: next_state = BYTE2;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

    // Output logic
    always @(posedge clk) begin
        if (reset) begin
            done <= 1'b0;
        end else begin
            if (state == BYTE3) begin
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
        end
    end

endmodule
