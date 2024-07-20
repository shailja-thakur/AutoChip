module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);
    
    // State declaration
    typedef enum reg [2:0] {
        IDLE,
        START,
        DATA,
        STOP
    } state_t;

    state_t state, next_state;
    reg [2:0] bit_counter;
    reg [7:0] data;

    // State transition logic
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            bit_counter <= 3'd0;
            done <= 0;
        end else begin
            state <= next_state;

            if (state == DATA) begin
                data[bit_counter] <= in;  // Shift in data bits
                bit_counter <= bit_counter + 1;
            end

            if (state != DATA) begin
                bit_counter <= 0;  // Reset bit counter when not in DATA state
            end
        end
    end

    // Next state logic
    always @(*) begin
        next_state = state;  // Preserve current state by default
        done = 0;            // Default done is low
        
        case (state)
            IDLE: begin
                if (in == 0) begin  // Detect start bit
                    next_state = START;
                end
            end
            START: begin
                next_state = DATA;  // Move to DATA after start bit
            end
            DATA: begin
                if (bit_counter == 3'd7) begin  // Check if received all 8 data bits
                    next_state = STOP;
                end
            end
            STOP: begin
                if (in == 1) begin  // Check for stop bit
                    done = 1;
                    next_state = IDLE;  // Transition to IDLE after successful reception
                end else begin
                    next_state = IDLE;  // Stay in IDLE if stop bit is incorrect
                end
            end
            default: next_state = IDLE;
        endcase
    end

endmodule
