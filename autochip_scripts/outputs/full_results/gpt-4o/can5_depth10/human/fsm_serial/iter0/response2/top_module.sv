module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);
    // State encoding
    typedef enum logic [3:0] {
        IDLE    = 4'b0000,
        START   = 4'b0001,
        BIT_0   = 4'b0010,
        BIT_1   = 4'b0011,
        BIT_2   = 4'b0100,
        BIT_3   = 4'b0101,
        BIT_4   = 4'b0110,
        BIT_5   = 4'b0111,
        BIT_6   = 4'b1000,
        BIT_7   = 4'b1001,
        STOP    = 4'b1010
    } state_t;

    state_t state, next_state;

    // State transition and output logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            done <= 1'b0;
        end else begin
            state <= next_state;
        end
    end

    always_comb begin
        next_state = state;
        done = 1'b0;

        case (state)
            IDLE: begin
                if (in == 1'b0)
                    next_state = START;
            end
            START: begin
                next_state = BIT_0;
            end
            BIT_0: begin
                next_state = BIT_1;
            end
            BIT_1: begin
                next_state = BIT_2;
            end
            BIT_2: begin
                next_state = BIT_3;
            end
            BIT_3: begin
                next_state = BIT_4;
            end
            BIT_4: begin
                next_state = BIT_5;
            end
            BIT_5: begin
                next_state = BIT_6;
            end
            BIT_6: begin
                next_state = BIT_7;
            end
            BIT_7: begin
                next_state = STOP;
            end
            STOP: begin
                if (in == 1'b1) begin
                    done = 1'b0;
                    next_state = IDLE;
                end else begin
                    next_state = STOP;
                end
            end
        endcase
    end
endmodule
