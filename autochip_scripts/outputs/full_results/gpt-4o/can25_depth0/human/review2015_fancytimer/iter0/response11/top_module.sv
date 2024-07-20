module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack);

    // State declaration
    typedef enum reg [2:0] {
        IDLE,
        PATTERN_DETECT,
        READ_DELAY,
        COUNTING,
        WAIT_ACK
    } state_t;
    
    state_t current_state, next_state;
    
    // Pattern and delay storage 
    reg [3:0] pattern_shift;
    reg [3:0] delay_reg;
    reg [13:0] timer_count; // (delay + 1) * 1000 can be up to 16000, so need 14 bits
    
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
        end
        else begin
            current_state <= next_state;
        end
    end
    
    always @(posedge clk) begin
        if (reset) begin
            pattern_shift <= 4'b0000;
            delay_reg <= 4'b0000;
            timer_count <= 14'd0;
            counting <= 1'b0;
            done <= 1'b0;
        end
        else begin
            case (current_state)
                IDLE: begin
                    pattern_shift <= 4'b0000;
                    delay_reg <= 4'b0000;
                    timer_count <= 14'd0;
                    counting <= 1'b0;
                    done <= 1'b0;
                end
                PATTERN_DETECT: begin
                    pattern_shift <= {pattern_shift[2:0], data};
                    if (pattern_shift == 4'b1101) begin
                        delay_reg <= 4'b0000;
                    end
                end
                READ_DELAY: begin
                    delay_reg <= {delay_reg[2:0], data};
                end
                COUNTING: begin
                    if (timer_count > 0) begin
                        timer_count <= timer_count - 1;
                    end
                    else begin
                        done <= 1'b1;
                        counting <= 1'b0;
                    end
                end
                WAIT_ACK: begin
                    if (ack) begin
                        done <= 1'b0;
                    end
                end
            endcase
        end
    end
    
    // Next state logic
    always @(*) begin
        case (current_state)
            IDLE: begin
                if (reset == 1'b0) begin
                    next_state = PATTERN_DETECT;
                end
                else begin
                    next_state = IDLE;
                end
            end
            PATTERN_DETECT: begin
                if (pattern_shift == 4'b1101) begin
                    next_state = READ_DELAY;
                end
                else begin
                    next_state = PATTERN_DETECT;
                end
            end
            READ_DELAY: begin
                next_state = COUNTING;
            end
            COUNTING: begin
                if (timer_count == 0) begin
                    next_state = WAIT_ACK;
                end
                else begin
                    next_state = COUNTING;
                end
            end
            WAIT_ACK: begin
                if (ack == 1'b1) begin
                    next_state = IDLE;
                end
                else begin
                    next_state = WAIT_ACK;
                end
            end
            default: next_state = IDLE;
        endcase
    end
    
    // Countdown logic
    always @(posedge clk) begin
        if (current_state == READ_DELAY) begin
            timer_count <= (delay_reg + 1) * 1000 - 1;
            counting <= 1'b1;
        end 
        else if (current_state == COUNTING) begin
            if (timer_count > 0 && timer_count % 1000 == 0) begin
                count <= delay_reg - timer_count / 1000;
            end
        end
    end
endmodule
