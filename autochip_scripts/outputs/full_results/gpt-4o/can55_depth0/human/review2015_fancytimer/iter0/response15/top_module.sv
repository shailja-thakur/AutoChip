module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

    // Define state parameters
    typedef enum logic [2:0] {
        IDLE = 3'b000,
        CHECK_PATTERN = 3'b001,
        SHIFT_DELAY = 3'b010,
        COUNT_DOWN = 3'b011,
        WAIT_ACK = 3'b100
    } state_t;

    state_t state, next_state;

    reg [3:0] shift_reg;
    reg [3:0] delay;
    reg [12:0] cycle_counter; // 13 bits to count up to 8192 (more than 7*1000 cycles)

    // State Transition Logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Next State Logic
    always_comb begin
        next_state = state; // Default assignment
        case (state)
            IDLE: begin
                counting = 0;
                done = 0;
                if ({data, shift_reg[3:1]} == 4'b1101) begin
                    next_state = CHECK_PATTERN;
                end
            end

            CHECK_PATTERN: begin
                shift_reg = {shift_reg[2:0], data};
                if ({shift_reg[2:0], data} == 4'b1101) begin
                    next_state = SHIFT_DELAY;
                end else begin
                    next_state = IDLE; // Keep shifting until 1101 is received
                end
            end

            SHIFT_DELAY: begin
                shift_reg = {shift_reg[2:0], data};
                if (shift_reg[3]) begin // At the end of shifting 4 bits
                    delay = shift_reg;
                    cycle_counter = 0;
                    next_state = COUNT_DOWN; 
                end
            end

            COUNT_DOWN: begin
                counting = 1;
                if (cycle_counter < (delay + 1) * 1000 - 1) begin
                    cycle_counter = cycle_counter + 1;
                    count = (delay * 1000 - cycle_counter - 1) / 1000; // Calculate the current remaining time
                end else begin
                    counting = 0;
                    done = 1;
                    next_state = WAIT_ACK;
                end
            end

            WAIT_ACK: begin
                if (ack) begin
                    done = 0;
                    next_state = IDLE;
                end
            end

            default: next_state = IDLE; // Fallback to idle state
        endcase
    end

    // Shift register logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_reg <= 4'b0;
        end else begin
            shift_reg <= {shift_reg[2:0], data};
        end
    end

endmodule
