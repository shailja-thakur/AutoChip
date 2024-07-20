module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    typedef enum logic [2:0] {
        IDLE,
        PATTERN_DETECT,
        LOAD_DELAY,
        COUNT_DELAY,
        WAIT_ACK
    } state_t;
    
    state_t current_state, next_state;
    
    reg [9:0] cycle_counter;  // Counter for 1000 cycles
    reg [3:0] delay;  // To store the delay value
    reg [3:0] shift_reg;  // To store incoming bits for pattern detection
    reg [2:0] bit_count;  // To count the number of bits shifted

    // State machine for state transition
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    // Combinational logic for state transition
    always @(*) begin
        next_state = current_state;
        done = 0;
        counting = 0;
        
        case (current_state)
            IDLE: begin
                next_state = (shift_reg == 4'b1101) ? LOAD_DELAY : IDLE;
            end
            LOAD_DELAY: begin
                counting = 0;
                next_state = (bit_count == 3'd4) ? COUNT_DELAY : LOAD_DELAY;
            end
            COUNT_DELAY: begin
                counting = 1;
                next_state = (cycle_counter == 0 && delay == 0) ? WAIT_ACK : COUNT_DELAY;
            end
            WAIT_ACK: begin
                done = 1;
                next_state = ack ? IDLE : WAIT_ACK;
            end
            default: next_state = IDLE;
        endcase
    end

    // Sequential logic for state-specific actions
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_reg <= 4'b0;
            bit_count <= 3'b0;
            delay <= 4'b0;
            cycle_counter <= 10'd1000;
            count <= 4'b1111;  // Don't-care state
        end else begin
            case (current_state)
                IDLE: begin
                    shift_reg <= {shift_reg[2:0], data};  // Shift in data bits
                end
                LOAD_DELAY: begin
                    if (bit_count < 4) begin
                        delay <= {delay[2:0], data};  // Shift in delay bits
                        bit_count <= bit_count + 1;
                    end
                end
                COUNT_DELAY: begin
                    if (cycle_counter == 0) begin
                        if (delay > 0) begin
                            delay <= delay - 1;
                            count <= delay - 1;
                            cycle_counter <= 10'd999;  // Reset cycle counter to 1000
                        end else begin
                            counting <= 0;
                            done <= 1;
                        end
                    end else begin
                        cycle_counter <= cycle_counter - 1;
                    end
                end
                WAIT_ACK: begin
                    if (ack) begin
                        done <= 0;
                        count <= 4'b1111;  // Don't-care state
                        shift_reg <= 4'b0;
                        bit_count <= 3'b0;
                        cycle_counter <= 10'd1000;
                        delay <= 4'b0;
                    end
                end
            endcase
        end
    end

endmodule
