module top_module(
	input wire clk,
	input wire reset,
	input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    // State machine states
    typedef enum logic [2:0] {
        IDLE,
        PATTERN_DETECT,
        SHIFT_IN,
        COUNT,
        DONE
    } state_t;

    state_t state, next_state;
    reg [3:0] delay;
    reg [3:0] bit_counter;
    reg [15:0] cycle_counter;

    // State machine logic
    always_ff @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic
    always_comb begin
        next_state = state;
        case (state)
            IDLE: begin
                if (data == 1'b1)
                    next_state = PATTERN_DETECT;
            end
            PATTERN_DETECT: begin
                if (bit_counter == 4'd3) begin
                    if ({data, pattern[2:0]} == 4'b1101) 
                        next_state = SHIFT_IN;
                    else
                        next_state = IDLE;
                end
            end
            SHIFT_IN: begin
                if (bit_counter == 4'd3)
                    next_state = COUNT;
            end
            COUNT: begin
                if (cycle_counter == (delay + 1) * 1000 - 1)
                    next_state = DONE;
            end
            DONE: begin
                if (ack)
                    next_state = IDLE;
            end
        endcase
    end

    // Output and state registers
    always_ff @(posedge clk) begin
        if (reset) begin
            delay <= 4'd0;
            bit_counter <= 4'd0;
            cycle_counter <= 16'd0;
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    bit_counter <= 4'd0;
                    counting <= 1'b0;
                    done <= 1'b0;
                end
                PATTERN_DETECT: begin
                    bit_counter <= bit_counter + 1;
                end
                SHIFT_IN: begin
                    bit_counter <= bit_counter + 1;
                    if (bit_counter < 4'd3)
                        delay <= {delay[2:0], data};
                    else
                        bit_counter <= 4'd0;
                end
                COUNT: begin
                    cycle_counter <= cycle_counter + 1;
                    counting <= 1'b1;
                    count <= delay - cycle_counter[13:10]; // Track the remaining time by high bits of cycle_counter
                    if (cycle_counter == (delay + 1) * 1000 - 1) begin
                        counting <= 1'b0;
                        done <= 1'b1;
                    end
                end
                DONE: begin
                    if (ack) begin
                        done <= 1'b0;
                        delay <= 4'd0;
                        cycle_counter <= 16'd0;
                    end
                end
            endcase
        end
    end
endmodule
