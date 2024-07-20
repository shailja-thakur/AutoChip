module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    // define state machine states
    typedef enum reg [2:0] {
        IDLE,
        START,
        DATA,
        STOP
    } state_t;
    
    state_t current_state, next_state;
    reg [2:0] bit_counter;    // to count data bits
    reg [7:0] data_buffer;    // to store incoming bits
    
    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            bit_counter <= 0;
            data_buffer <= 0;
            done <= 0;
        end else begin
            current_state <= next_state;
            if (current_state == DATA && current_state != next_state) begin
                bit_counter <= 0;
            end else if (current_state == DATA) begin
                data_buffer[bit_counter] <= in;
                bit_counter <= bit_counter + 1;
            end
            done <= (current_state == STOP);
            if (done)
                out_byte <= data_buffer;
        end
    end
    
    // Next state logic
    always @(*) begin
        case (current_state)
            IDLE: begin
                if (!in)  // start bit (0) detected
                    next_state = START;
                else
                    next_state = IDLE;
            end

            START: begin
                next_state = DATA;  // Move to data state after detecting start bit
            end

            DATA: begin
                if (bit_counter == 7) // received 8 bits of data
                    next_state = STOP;
                else
                    next_state = DATA;
            end

            STOP: begin
                if (in)  // stop bit (1) detected
                    next_state = IDLE;
                else
                    next_state = STOP;
            end

            default: next_state = IDLE;
        endcase
    end

endmodule
