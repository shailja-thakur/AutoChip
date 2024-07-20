module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    // State encoding
    typedef enum logic [2:0] {
        IDLE,
        PATTERN_DETECT,
        LOAD_DELAY,
        COUNTING,
        WAIT_ACK
    } state_t;

    state_t state, next_state;
    
    reg [3:0] bit_counter;    // Counter to shift in bits
    reg [3:0] delay;          // Register to hold the duration delay
    reg [13:0] cycle_counter; // Counter for 1000 cycles * (delay + 1)

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counting <= 0;
            done <= 0;
            cycle_counter <= 0;
            bit_counter <= 0;
            delay <= 0;
        end
        else begin
            state <= next_state;
            
            // Counting Logic
            if (state == COUNTING) begin
                if (cycle_counter == 0) begin
                    if (count > 0) begin
                        count <= count - 1;
                        cycle_counter <= 999; // Start next 1000 cycle count
                    end
                    else begin
                        counting <= 0;
                        done <= 1;
                        next_state <= WAIT_ACK;
                    end
                end
                else begin
                    cycle_counter <= cycle_counter - 1;
                end
            end
            
            // State actions
            case (state)
                IDLE: begin
                    counting <= 0;
                    done <= 0;
                end
                
                PATTERN_DETECT: begin
                    if (bit_counter == 3) begin
                        next_state <= LOAD_DELAY;
                        bit_counter <= 0;
                    end
                    else begin
                        bit_counter <= bit_counter + 1;
                    end
                end
                
                LOAD_DELAY: begin
                    // Shift in 4 bits for delay
                    delay <= {delay[2:0], data};
                    if (bit_counter == 3) begin
                        count <= {delay[2:0], data};
                        next_state <= COUNTING;
                        cycle_counter <= 1000;  // Initialize cycle counter
                        counting <= 1;
                    end
                    else begin
                        bit_counter <= bit_counter + 1;
                    end
                end
                
                WAIT_ACK: begin
                    if (ack) begin
                        next_state <= IDLE;
                    end
                end
            endcase
        end
    end

    // State transition logic
    always_comb begin
        next_state = state;
        case (state)
            IDLE: begin
                if (data)
                    next_state = PATTERN_DETECT;
            end
            
            PATTERN_DETECT: begin
                if (data)
                    next_state = PATTERN_DETECT;
                else
                    next_state = IDLE;
            end
            
            LOAD_DELAY: begin
                next_state = LOAD_DELAY;
            end
            
            COUNTING: begin
                next_state = COUNTING;
            end
            
            WAIT_ACK: begin
                next_state = WAIT_ACK;
            end
        endcase
    end

endmodule
