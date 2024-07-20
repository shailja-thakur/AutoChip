module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

    // State encoding
    typedef enum reg [2:0] {
        STATE_IDLE    = 3'd0,
        STATE_PATTERN = 3'd1,
        STATE_DELAY   = 3'd2,
        STATE_COUNT   = 3'd3,
        STATE_DONE    = 3'd4
    } state_t;
    state_t state, next_state;
    
    // Shift register for detecting the pattern and loading the delay
    reg [3:0] shift_reg;
    
    // Timer and delay register
    reg [3:0] delay;
    reg [13:0] timer; // Timer to handle up to 16 * 1000 cycles
    
    always @(posedge clk) begin
        if (reset) begin
            state <= STATE_IDLE;
            shift_reg <= 4'd0;
            delay <= 4'd0;
            timer <= 14'd0;
            counting <= 1'b0;
            done <= 1'b0;
            count <= 4'd0;
        end else begin
            state <= next_state;
            
            case (state)
                STATE_IDLE: begin
                    shift_reg <= {shift_reg[2:0], data};
                end
                
                STATE_PATTERN: begin
                    if (shift_reg == 4'b1101) begin
                        shift_reg <= {shift_reg[2:0], data};
                    end else begin
                        shift_reg <= {shift_reg[2:0], data};
                    end
                end
                
                STATE_DELAY: begin
                    delay <= {shift_reg[2:0], data};
                    shift_reg <= 4'd0;
                end
                
                STATE_COUNT: begin
                    if (timer > 0) begin
                        timer <= timer - 1;
                    end
                    
                    if(timer % 1000 == 0) begin
                        count <= count - 1;
                    end
                end
            endcase
        end
    end

    always @(*) begin
        next_state = state;
        counting = 1'b0;
        done = 1'b0;
        
        case (state)
            STATE_IDLE: begin
                if (shift_reg == 4'b1101) begin
                    next_state = STATE_PATTERN;
                end
            end
            
            STATE_PATTERN: begin
                if (shift_reg == 4'b1101) begin
                    next_state = STATE_DELAY;
                end else begin
                    next_state = STATE_IDLE; // continue searching for 1101 pattern
                end
            end
            
            STATE_DELAY: begin
                next_state = STATE_COUNT;
                timer = (delay + 1) * 1000;
                count = delay + 1;
            end
            
            STATE_COUNT: begin
                counting = 1'b1;
                if (timer == 0) begin
                    next_state = STATE_DONE;
                end
            end
            
            STATE_DONE: begin
                done = 1'b1;
                if (ack) begin
                    next_state = STATE_IDLE;
                end
            end
        endcase
    end

endmodule
