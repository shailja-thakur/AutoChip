module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);
    
    // State Declaration
    typedef enum reg [2:0] {
        IDLE,
        START,
        DATA_0,
        DATA_1,
        DATA_2,
        DATA_3,
        DATA_4,
        DATA_5,
        DATA_6,
        DATA_7,
        STOP
    } state_t;
    
    state_t current_state, next_state;
    reg [2:0] data_count; // bits counter
    
    // Synchronous state transition
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end
    
    // Next state logic
    always @(*) begin
        next_state = current_state;
        done = 0;
        case (current_state)
            IDLE: begin
                if (in == 0) // Start bit detected
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
                if (in == 1) // expected Stop bit
                    next_state = STOP;
                else
                    next_state = IDLE;
            end
            STOP: begin
                done = 1;
                next_state = IDLE;
            end
        endcase
    end
    
    // Update output done, it is high one clock cycle after STOP state.
    always @(posedge clk or posedge reset) begin
        if (reset) 
            done <= 0;
        else if (current_state == STOP)
            done <= 1;
        else
            done <= 0;
    end
endmodule
