module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    // State Declaration
    typedef enum reg [2:0] {
        IDLE,
        PATTERN_DETECT,
        READ_DELAY,
        COUNTING,
        DONE
    } state_t;

    state_t current_state, next_state;
    
    // Pattern detection variables and counters
    reg [3:0] pattern_shift;
    reg [3:0] delay;
    reg [15:0] cycle_counter;
    wire [15:0] total_cycles;
    
    // Count the input clock cycles
    assign total_cycles = (delay + 1) * 1000;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            pattern_shift <= 0;
            delay <= 0;
            cycle_counter <= 0;
            counting <= 0;
            done <= 0;
            count <= 0;
        end else begin
            current_state <= next_state;

            if (current_state == PATTERN_DETECT) begin
                pattern_shift <= {pattern_shift[2:0], data};
            end else if (current_state == READ_DELAY) begin
                delay <= {delay[2:0], data};
            end else if (current_state == COUNTING) begin
                cycle_counter <= cycle_counter + 1;
                if (cycle_counter % 1000 == 0)
                    count <= count - 1;
            end else if (current_state == IDLE || current_state == DONE) begin
                cycle_counter <= 0;
                count <= 4'b1111; // don't-care value
            end
        end
    end
    
    always @(*) begin
        next_state = current_state;
        case (current_state)
            IDLE: begin
                counting = 0;
                done = 0;
                if (pattern_shift == 4'b1101) begin
                    next_state = READ_DELAY;
                end else begin
                    next_state = PATTERN_DETECT;
                end
            end

            PATTERN_DETECT: begin
                counting = 0;
                done = 0;
                if (pattern_shift == 4'b1101) begin
                    next_state = READ_DELAY;
                end
            end

            READ_DELAY: begin
                counting = 0;
                done = 0;
                if (&delay[2:0]) begin // After 4-bit delay value is fully read
                    next_state = COUNTING;
                    count = delay;
                end
            end

            COUNTING: begin
                counting = 1;
                done = 0;
                if (cycle_counter == total_cycles - 1) begin
                    next_state = DONE;
                end
            end

            DONE: begin
                counting = 0;
                done = 1;
                if (ack == 1) begin
                    next_state = IDLE;
                end
            end
        endcase
    end
endmodule
