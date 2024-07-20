module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

    // State encoding
    typedef enum reg [2:0] {
        IDLE      = 3'b000,
        READ_SEQ  = 3'b001,
        READ_DELAY = 3'b010,
        COUNT     = 3'b011,
        DONE      = 3'b100
    } state_t;

    reg [2:0] state, next_state;
    reg [3:0] shift_reg;
    reg [9:0] delay_count;
    reg [9:0] cycle_count;
    reg [3:0] input_delay;

    // State transitions
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic and control signals
    always @(*) begin
        next_state = state;
        done = 0;
        counting = 0;
        case (state)
            IDLE: begin
                if (shift_reg == 4'b1101)
                    next_state = READ_DELAY;
            end
            READ_DELAY: begin
                if (shift_reg == 4'b0000) begin
                    input_delay = shift_reg;
                    next_state = COUNT;
                end
            end
            COUNT: begin
                counting = 1;
                if (cycle_count == 0) begin
                    if (delay_count == 0)
                        next_state = DONE;
                    else begin
                        delay_count = delay_count - 1;
                        cycle_count = 999;
                        count = delay_count[3:0];
                    end
                end
                else
                    cycle_count = cycle_count - 1;
            end
            DONE: begin
                done = 1;
                if (ack)
                    next_state = IDLE;
            end
        endcase
    end

    // Shift register for detecting input pattern and delay
    always @(posedge clk or posedge reset) begin
        if (reset)
            shift_reg <= 4'b0000;
        else if (state == READ_SEQ || state == READ_DELAY)
            shift_reg <= {shift_reg[2:0], data};
    end

    // Delay counter
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            cycle_count <= 10'b0;
            delay_count <= 10'b0;
            count <= 4'b0;
        end
        else if (state == READ_DELAY && state != COUNT) begin
            delay_count <= (shift_reg + 1) * 1000;
            cycle_count <= 999;
            count <= shift_reg;
        end
    end

    // Control logic for the 'done' signal
    always @(posedge clk or posedge reset) begin
        if (reset)
            done <= 1'b0;
        else if (state == DONE && ack)
            done <= 1'b0;
        else if (state == DONE)
            done <= 1'b1;
    end

endmodule
