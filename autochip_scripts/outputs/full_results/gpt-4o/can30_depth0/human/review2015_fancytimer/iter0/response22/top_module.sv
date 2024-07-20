module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    // State definitions
    typedef enum logic [2:0] {
        IDLE = 3'b000,
        DETECT_1 = 3'b001,
        DETECT_11 = 3'b010,
        DETECT_110 = 3'b011,
        DETECT_1101 = 3'b100,
        LOAD_DELAY = 3'b101,
        COUNTDOWN = 3'b110,
        WAIT_ACK = 3'b111
    } state_t;
    
    state_t state, next_state;
    reg [3:0] delay;  // Holds the delay value
    reg [15:0] count_1ms; // Counts up to 1000 for each delay unit

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic and output logic
    always @* begin
        next_state = state;
        counting = 0;
        done = 0;
        count = 4'bxxxx;
        count_1ms = count_1ms;

        case (state)
            IDLE: begin
                if (data)
                    next_state = DETECT_1;
            end
            DETECT_1: begin
                if (!data) next_state = IDLE;
                else next_state = DETECT_11;
            end 
            DETECT_11: begin
                if (data) next_state = DETECT_110;
                else next_state = IDLE;
            end 
            DETECT_110: begin
                if (!data) next_state = DETECT_1101;
                else next_state = IDLE;
            end 
            DETECT_1101: begin
                if (!data) begin 
                    next_state = LOAD_DELAY;
                    delay = 0;
                end
                else next_state = IDLE;
            end 
            
            LOAD_DELAY: begin
                delay = (delay << 1) | data;
                if (&delay) // If all bits of delay filled
                    next_state = COUNTDOWN;
            end 
            
            COUNTDOWN: begin
                counting = 1;
                if (count_1ms == 1000) begin
                    if (delay == 0)
                        next_state = WAIT_ACK;
                    else begin
                        delay = delay - 1;
                        count_1ms = 0;
                    end
                end
                else begin
                    count_1ms = count_1ms + 1;
                end
                count = delay;
            end 
            
            WAIT_ACK: begin
                done = 1;
                if (ack)
                    next_state = IDLE;
            end 
            
            default: 
                next_state = IDLE;
        endcase
    end
endmodule
