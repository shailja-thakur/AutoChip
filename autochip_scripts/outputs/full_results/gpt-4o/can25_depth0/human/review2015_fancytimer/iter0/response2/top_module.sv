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
        COUNT,
        DONE
    } state_t;
    
    state_t current_state, next_state;

    reg [2:0] bit_count;  // Counter for pattern and delay bit shifts
    reg [3:0] delay;  // To store the 4-bit delay

    // Counter for 1000 cycles
    reg [9:0] cycle_counter;
    reg [3:0] remaining_time;
    
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            bit_count <= 0;
            delay <= 0;
            cycle_counter <= 0;
            remaining_time <= 0;
            counting <= 0;
            done <= 0;
        end else begin
            current_state <= next_state;
            if (current_state == PATTERN_DETECT || current_state == LOAD_DELAY)
                bit_count <= bit_count + 1;
            if (current_state == LOAD_DELAY) begin
                delay <= {delay[2:0], data};
            end
            if (current_state == COUNT) begin
                cycle_counter <= cycle_counter + 1;
                if (cycle_counter == 999) begin
                    cycle_counter <= 0;
                    remaining_time <= remaining_time - 1;
                end
            end
            if (ack) begin
                done <= 0;
            end
        end
    end

    always_comb begin
        next_state = current_state;
        case (current_state)
            IDLE: begin
                if (data == 1) begin
                    next_state = PATTERN_DETECT;
                end
                counting = 0;
                count = 4'bxxxx;
                done = 0;
            end
            
            PATTERN_DETECT: begin
                if (bit_count == 3) begin
                    if ({delay[2:0], data} == 4'b1101) begin
                        next_state = LOAD_DELAY;
                    end else begin
                        next_state = IDLE;
                    end
                end
                counting = 0;
                count = 4'bxxxx;
                done = 0;
            end
            
            LOAD_DELAY: begin
                if (bit_count == 7) begin
                    next_state = COUNT;
                    remaining_time = delay;
                    cycle_counter = 0;
                end
                counting = 0;
                count = 4'bxxxx;
                done = 0;
            end
            
            COUNT: begin
                if (remaining_time == 0 && cycle_counter == 999) begin
                    next_state = DONE;
                end
                counting = 1;
                count = remaining_time;
                done = 0;
            end
            
            DONE: begin
                if (ack) begin
                    next_state = IDLE;
                end
                counting = 0;
                count = 4'bxxxx;
                done = 1;
            end
        endcase
    end
endmodule
