module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);
    // State encoding
    typedef enum logic [2:0] {
        IDLE    = 3'b000,
        PATTERN = 3'b001,
        LOAD    = 3'b010,
        COUNT   = 3'b011,
        DONE    = 3'b100
    } state_t;

    state_t state, next_state;
    reg [3:0] shift_reg;
    reg [9:0] counter;
    reg [3:0] delay, remaining_delay;
    reg [13:0] total_cycles;

    assign count = (counting) ? remaining_delay : 4'bxxxx;

    // State transition
    always @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // State machine logic
    always @* begin
        next_state = state;  // Default to stay in the same state
        case(state)
            IDLE: begin
                if (!reset) begin
                    shift_reg = 4'b0000;  // Initialize shift register
                    counter = 0;
                    delay = 0;
                    done = 0;
                    counting = 0;
                    next_state = PATTERN;
                end
            end
            PATTERN: begin
                // Shift in data
                shift_reg = {shift_reg[2:0], data};
                if (shift_reg == 4'b1101) begin
                    next_state = LOAD;
                end
            end
            LOAD: begin
                shift_reg = {shift_reg[2:0], data};
                if (shift_reg == 4'b0000) begin // After 4 bits have been shifted in
                    delay = shift_reg;
                    total_cycles = (shift_reg + 1) * 1000;
                    counting = 1;
                    next_state = COUNT;
                end
            end
            COUNT: begin
                if (counter < 1000) begin
                    counter = counter + 1;
                end else begin
                    counter = 0;
                    if (remaining_delay > 0)
                        remaining_delay = remaining_delay - 1;
                    else
                        next_state = DONE;
                end
            end
            DONE: begin
                counting = 0;
                done = 1;
                if (ack)
                    next_state = PATTERN;
            end
        endcase
    end

    // Remaining time logic
    always @(posedge clk) begin
        if (reset) begin
            remaining_delay <= 0;
        end else if (state == COUNT && counter == 0) begin
            remaining_delay <= delay;
        end
    end

endmodule
