module top_module(
	input wire clk,
	input wire reset,
	input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

    // State machine states
    typedef enum logic [2:0] {
        IDLE,        // Initial state
        PATTERN,     // Detecting pattern 1101
        SHIFT,       // Shifting in delay bits
        COUNT,       // Counting delay * 1000 cycles
        WAIT_ACK     // Waiting for user acknowledgment
    } state_t;

    state_t state, next_state;
    reg [3:0] shift_reg;    // Shift register for detecting pattern and capturing delay
    reg [3:0] delay;        // Delay duration
    reg [12:0] counter;     // Counter for counting 1000 cycles
    reg [3:0] remaining_time; // Remaining time for the delay

    // State machine transitions
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // State machine output logic
    always_comb begin
        next_state = state;

        case (state)
            IDLE: begin
                done = 1'b0;
                counting = 1'b0;
                if (shift_reg[3:0] == 4'b1101) begin
                    next_state = SHIFT;
                end
            end

            PATTERN: begin
                done = 1'b0;
                counting = 1'b0;
                if (shift_reg[3:0] == 4'b1101) begin
                    delay = shift_reg[7:4];
                    next_state = SHIFT;
                end
            end

            SHIFT: begin
                done = 1'b0;
                counting = 1'b0;
                if (shift_reg[3:0] == 4'b1101) begin
                    if (shift_reg[7:4] != 4'b0000) begin
                        delay = shift_reg[7:4];
                        remaining_time = shift_reg[7:4];
                        next_state = COUNT;
                    end
                end
            end

            COUNT: begin
                done = 1'b0;
                counting = 1'b1;
                if (counter == 13'd999) begin
                    counter = 0;
                    if (remaining_time == 0) begin
                        next_state = WAIT_ACK;
                    end else begin
                        remaining_time = remaining_time - 1;
                    end
                end else begin
                    counter = counter + 1;
                end
            end

            WAIT_ACK: begin
                done = 1'b1;
                counting = 1'b0;
                if (ack) begin
                    next_state = IDLE;
                end
            end

            default: next_state = IDLE;
        endcase
    end

    // Shift register for pattern detection and delay capture
    always_ff @(posedge clk) begin
        if (reset) begin
            shift_reg <= 4'b0;
        end else if (state == IDLE) begin
            shift_reg = {shift_reg[2:0], data};
        end else if (next_state == SHIFT) begin
            shift_reg = {shift_reg[2:0], data};
        end
    end

    // Update count output
    always_ff @(posedge clk) begin
        if (counting) begin
            count <= remaining_time;
        end else begin
            count <= 4'bxxxx;  // Don't-care value when not counting
        end
    end

    // Counter for 1000 cycles
    always_ff @(posedge clk) begin
        if (reset || (state != COUNT)) begin
            counter <= 0;
        end else if (counting && counter < 13'd999) begin
            counter <= counter + 1;
        end else begin
            counter <= 0;
        end
    end

endmodule
