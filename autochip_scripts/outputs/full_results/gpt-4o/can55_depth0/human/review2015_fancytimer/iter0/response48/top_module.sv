module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack 
);
    
    // State definitions
    typedef enum reg [2:0] {
        IDLE,
        WAIT_PATTERN,
        READ_DELAY,
        COUNT,
        DONE
    } state_t;
    
    state_t state, next_state;
    reg [3:0] shift_reg;
    reg [3:0] delay;
    reg [15:0] counter;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= WAIT_PATTERN;
            shift_reg <= 4'b0;
            counting <= 0;
            done <= 0;
            delay <= 0;
            counter <= 0;
        end
        else begin
            state <= next_state;
        end
    end

    always @(posedge clk) begin
        if (state == WAIT_PATTERN) begin
            shift_reg <= {shift_reg[2:0], data};
        end
        else if (state == READ_DELAY) begin
            shift_reg <= {shift_reg[2:0], data};
        end
    end

    always @(*) begin
        next_state = state;
        counting = 0;
        done = 0;
        
        case (state)
            WAIT_PATTERN: begin
                if (shift_reg == 4'b1101) begin
                    next_state = READ_DELAY;
                end
            end
            
            READ_DELAY: begin
                if (shift_reg == 4'b0001) begin // This would mean all 4 bits shifted in
                    delay = shift_reg;
                    counter = (delay + 1) * 1000;
                    next_state = COUNT;
                end
            end
            
            COUNT: begin
                counting = 1;
                if (counter == 0) begin
                    next_state = DONE;
                end
                else begin
                    counter = counter - 1;
                end
            end
            
            DONE: begin
                done = 1;
                if (ack) begin
                    next_state = WAIT_PATTERN;
                end
            end
            
            default: begin
                next_state = WAIT_PATTERN;
            end
        endcase
    end
    
    assign count = (state == COUNT) ? counter[15:12] : 4'bxxxx;
    
endmodule
