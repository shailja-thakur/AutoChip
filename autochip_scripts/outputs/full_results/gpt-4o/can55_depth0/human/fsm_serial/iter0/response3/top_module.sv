module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // States of the FSM
    typedef enum reg [2:0] {
        IDLE,       // 0
        START,      // 1
        DATA_0,     // 2
        DATA_1,     // 3
        DATA_2,     // 4
        DATA_3,     // 5
        DATA_4,     // 6
        DATA_5,     // 7
        DATA_6,     // 8 
        DATA_7,     // 9
        STOP        // 10
    } state_t;
    
    state_t state, next_state;
    reg [2:0] bit_count;

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_count <= 3'd0;
            done <= 1'b0;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        next_state = state;
        done = 1'b0;
        case (state)
            IDLE: begin
                if (in == 1'b0)
                    next_state = START;
            end
            START: begin
                next_state = DATA_0;
            end
            DATA_0: begin
                next_state = DATA_1;
            end
            DATA_1: begin
                next_state = DATA_2;
            end
            DATA_2: begin
                next_state = DATA_3;
            end
            DATA_3: begin
                next_state = DATA_4;
            end
            DATA_4: begin
                next_state = DATA_5;
            end
            DATA_5: begin
                next_state = DATA_6;
            end
            DATA_6: begin
                next_state = DATA_7;
            end
            DATA_7: begin
                next_state = STOP;
            end
            STOP: begin
                if (in == 1'b1) begin
                    done = 1'b1;
                    next_state = IDLE;
                end else begin
                    next_state = IDLE;
                end
            end
            default: next_state = IDLE;
        endcase
    end

    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            bit_count <= 3'd0;
        end else begin
            if (state >= DATA_0 && state <= DATA_7) begin
                bit_count <= bit_count + 1'b1;
            end else if (state == STOP) begin
                bit_count <= 3'd0;
            end
        end
    end

endmodule
