module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

    typedef enum reg [2:0] {
        IDLE,
        PATTERN_CHECK,
        LOAD_DELAY,
        COUNTDOWN,
        DONE_STATE
    } state_t;

    state_t current_state, next_state;
    reg [3:0] shift_reg;       // Shift register to detect pattern and load delay
    reg [2:0] bit_count;       // Counter for incoming bits
    reg [3:0] delay;           // Delay duration in 1000 cycles
    reg [12:0] cycle_count;    // Cycle counter

    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            shift_reg <= 4'b0000;
            bit_count <= 3'd0;
            count <= 4'd0;
            delay <= 4'd0;
            cycle_count <= 13'd0;
            counting <= 1'b0;
            done <= 1'b0;
        end
        else begin
            current_state <= next_state;
            if (current_state == PATTERN_CHECK || current_state == LOAD_DELAY) begin
                shift_reg <= {shift_reg[2:0], data};   // Shift in new data bit
                bit_count <= bit_count + 1'b1;
            end

            if (current_state == COUNTDOWN) begin
                if (cycle_count == 13'd999) begin
                    cycle_count <= 13'd0;
                    count <= count - 1'b1;
                end else begin
                    cycle_count <= cycle_count + 1'b1;
                end
            end
        end
    end

    always @(*) begin
        next_state = current_state;  // Default state
        case (current_state)
            IDLE: begin
                counting = 1'b0;
                done = 1'b0;
                bit_count = 3'd0;
                if (shift_reg == 4'b1101) begin
                    next_state = LOAD_DELAY;
                end
            end
            PATTERN_CHECK: begin
                counting = 1'b0;
                done = 1'b0;
                if (bit_count == 3'd3) begin
                    if (shift_reg == 4'b1101) begin
                        next_state = LOAD_DELAY;
                    end else begin
                        next_state = IDLE;
                    end
                end
            end
            LOAD_DELAY: begin
                counting = 1'b0;
                done = 1'b0;
                if (bit_count == 3'd7) begin
                    delay = shift_reg[3:0];
                    count = shift_reg[3:0];
                    next_state = COUNTDOWN;
                end
            end
            COUNTDOWN: begin
                counting = 1'b1;
                done = 1'b0;
                if (count == 4'd0 && cycle_count == 13'd999) begin
                    next_state = DONE_STATE;
                end
            end
            DONE_STATE: begin
                counting = 1'b0;
                done = 1'b1;
                if (ack == 1'b1) begin
                    next_state = IDLE;
                end
            end
        endcase
    end

endmodule
