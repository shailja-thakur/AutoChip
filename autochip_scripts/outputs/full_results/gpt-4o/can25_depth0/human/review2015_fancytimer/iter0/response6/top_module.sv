module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    // Define states
    typedef enum logic [2:0] {
        IDLE,
        SEARCH_PATTERN,
        SHIFT_DURATION,
        COUNT,
        WAIT_ACK
    } state_t;

    state_t state, next_state;
    reg [2:0] pattern_shift; // To detect the pattern
    reg [3:0] duration; // Holds delay[3:0]
    reg [13:0] cycle_counter; // Counting cycles [0 to 9999]

    always_ff @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            pattern_shift <= 3'b000;
            duration <= 4'b0000;
            cycle_counter <= 14'b0;
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            state <= next_state;
            // Update registers for transition
            case (state)
                IDLE: begin
                    pattern_shift <= 3'b000;
                    duration <= 4'b0000;
                    cycle_counter <= 14'b0;
                    counting <= 1'b0;
                    done <= 1'b0;
                end
                SEARCH_PATTERN: begin
                    pattern_shift <= {pattern_shift[1:0], data};
                end
                SHIFT_DURATION: begin
                    duration <= {duration[2:0], data};
                end
                COUNT: begin
                    if (cycle_counter < (duration * 1000) + 999) begin
                        cycle_counter <= cycle_counter + 1;
                    end else begin
                        cycle_counter <= 0;
                        done <= 1'b1;
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

    always_comb begin
        next_state = state;
        case (state)
            IDLE: begin
                if (reset) next_state = IDLE; 
                else next_state = SEARCH_PATTERN;
            end
            SEARCH_PATTERN: begin
                if (pattern_shift == 3'b101 && data == 1'b1) begin
                    next_state = SHIFT_DURATION;
                end
            end
            SHIFT_DURATION: begin
                if (duration == 4'b1111) begin
                    next_state = COUNT;
                    counting = 1'b1;
                end
            end
            COUNT: begin
                if (done) begin
                    next_state = WAIT_ACK;
                    counting = 1'b0;
                end
            end
            WAIT_ACK: begin
                if (ack) begin
                    next_state = IDLE;
                end
            end
        endcase
    end

    assign count = done ? 4'b0000 : (cycle_counter / 1000);

endmodule
