module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

    // State declarations
    typedef enum logic [2:0] {
        S_WAIT_PATTERN = 3'd0,
        S_SHIFT_DELAY  = 3'd1,
        S_COUNTING     = 3'd2,
        S_DONE         = 3'd3
    } state_t;
    
    state_t state, next_state;
    reg [3:0] pattern_buffer;
    reg [3:0] delay;
    reg [12:0] counter;
    
    // Constants
    localparam PATTERN = 4'b1101;
    localparam CYCLE_MULTIPLIER = 1000;
    
    always_comb begin
        // Default values for outputs
        next_state = state;
        case (state)
            S_WAIT_PATTERN: begin
                if (pattern_buffer == PATTERN)
                    next_state = S_SHIFT_DELAY;
            end
            S_SHIFT_DELAY: begin
                next_state = (counter == 4) ? S_COUNTING : S_SHIFT_DELAY;
            end
            S_COUNTING: begin
                next_state = (counter == 0) ? S_DONE : S_COUNTING;
            end
            S_DONE: begin
                if (ack)
                    next_state = S_WAIT_PATTERN;
            end
        endcase
    end
    
    // State machine
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= S_WAIT_PATTERN;
            pattern_buffer <= 4'b0000;
            delay <= 4'b0000;
            counter <= 13'b0;
            count <= 4'b0000;
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            state <= next_state;

            case (state)
                S_WAIT_PATTERN: begin
                    pattern_buffer <= {pattern_buffer[2:0], data};
                    counting <= 1'b0;
                    done <= 1'b0;
                end
                
                S_SHIFT_DELAY: begin
                    pattern_buffer <= {pattern_buffer[2:0], data};
                    delay <= {delay[2:0], data};
                    counter <= counter + 1'b1;
                end
                
                S_COUNTING: begin
                    counting <= 1'b1;
                    count <= (counter / CYCLE_MULTIPLIER);
                    if (counter == delay * CYCLE_MULTIPLIER)
                        counter <= 13'b0;
                    else
                        counter <= counter - 1;
                end
                
                S_DONE: begin
                    counting <= 1'b0;
                    done <= 1'b1;
                    if (ack) begin
                        pattern_buffer <= 4'b0000;
                        delay <= 4'b0000;
                        counter <= 13'b0;
                        count <= 4'b0000;
                        done <= 1'b0;
                    end
                end
            endcase
        end
    end
endmodule
