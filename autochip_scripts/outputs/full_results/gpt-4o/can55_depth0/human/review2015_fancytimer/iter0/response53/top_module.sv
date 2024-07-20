module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

    // States for state machine
    typedef enum reg [2:0] {
        IDLE,
        PATTERN_DETECT,
        LOAD_DELAY,
        COUNTING,
        WAIT_ACK
    } state_t;

    state_t state, next_state;

    // Registers for delay and counter
    reg [3:0] delay, delay_counter;
    reg [2:0] bit_counter; // to count 4 bits after pattern is detected
    reg [9:0] cycle_counter; // to count 1000 cycles

    // State machine
    always @(posedge clk) begin
        if (reset) 
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (data == 1'b1) 
                    next_state = PATTERN_DETECT;
                else
                    next_state = IDLE;
            end
            
            PATTERN_DETECT: begin
                if (data == 1'b1 && bit_counter == 3'b110) 
                    next_state = LOAD_DELAY;
                else
                    next_state = PATTERN_DETECT;
            end
            
            LOAD_DELAY: begin
                if (bit_counter == 3'b100)
                    next_state = COUNTING;
                else
                    next_state = LOAD_DELAY;
            end
            
            COUNTING: begin
                if (delay == 4'b0000 && cycle_counter == 10'b1111101000) 
                    next_state = WAIT_ACK;
                else
                    next_state = COUNTING;
            end

            WAIT_ACK: begin
                if (ack) 
                    next_state = IDLE;
                else
                    next_state = WAIT_ACK;
            end
            
            default: next_state = IDLE;

        endcase
    end

    // Output and internal register logic
    always @(posedge clk ) begin
        if (reset) begin
            bit_counter <= 3'b0;
            delay <= 4'b0;
            delay_counter <= 4'b0;
            cycle_counter <= 10'b0;
            counting <= 1'b0;
            done <= 1'b0;
            count <= 4'bxxxx; // Don't care value when not counting
        end
        else begin
            case (next_state)
                IDLE: begin
                    bit_counter <= 3'b0;
                    delay <= 4'b0;
                    delay_counter <= 4'b0;
                    cycle_counter <= 10'b0;
                    counting <= 1'b0;
                    done <= 1'b0;
                    count <= 4'bxxxx;
                end
                
                PATTERN_DETECT: begin
                    bit_counter <= bit_counter + 3'b001;
                end
                
                LOAD_DELAY: begin
                    delay[3-bit_counter] <= data;
                    bit_counter <= bit_counter + 3'b001;
                end

                COUNTING: begin
                    counting <= 1'b1;
                    if (cycle_counter < 10'b1111101000) begin
                        cycle_counter <= cycle_counter + 10'b1;
                    end
                    else begin
                        cycle_counter <= 10'b0;
                        if (delay > 4'b0) 
                            delay <= delay - 4'b1;
                        else
                            counting <= 1'b0;
                    end
                    count <= delay;
                end

                WAIT_ACK: begin
                    done <= 1'b1;
                    counting <= 1'b0;
                    if (ack)
                        done <= 1'b0;
                end
            endcase
        end
    end
endmodule
