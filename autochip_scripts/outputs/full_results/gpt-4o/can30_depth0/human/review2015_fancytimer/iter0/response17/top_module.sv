module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack 
);

    // Declare states for the state machine
    typedef enum reg [2:0] {
        IDLE = 3'b000,
        SEARCH_PATTERN = 3'b001,
        LOAD_DELAY = 3'b010,
        COUNTING = 3'b011,
        DONE = 3'b100
    } state_t;
    
    state_t state, next_state;
    reg [3:0] shift_reg;
    reg [3:0] delay;
    reg [13:0] cycle_count;  // 14 bits to count up to 10000 cycles

    // State machine: state transition
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // State machine: next state and outputs
    always @(*) begin
        case(state)
            IDLE: begin
                counting = 0;
                done = 0;
                count = 4'bxxxx;
                if (data)
                    next_state = SEARCH_PATTERN;
                else
                    next_state = IDLE;
            end

            SEARCH_PATTERN: begin
                counting = 0;
                done = 0;
                count = 4'bxxxx;
                if (shift_reg == 4'b1101)
                    next_state = LOAD_DELAY;
                else
                    next_state = SEARCH_PATTERN;
            end

            LOAD_DELAY: begin
                counting = 0;
                done = 0;
                count = 4'bxxxx;
                if (shift_reg[3:0] == 4'bxxxx)  // Wait till complete 4 bits are shifted
                    next_state = LOAD_DELAY;
                else
                    next_state = COUNTING;
            end

            COUNTING: begin
                counting = 1;
                done = 0;
                count = cycle_count[13:10]; // Get the upper 4 bits of the cycle count for display
                if (cycle_count == 0)
                    next_state = DONE;
                else
                    next_state = COUNTING;
            end

            DONE: begin
                counting = 0;
                done = 1;
                count = 4'bxxxx;
                if (ack)
                    next_state = IDLE;
                else
                    next_state = DONE;
            end

            default: begin
                counting = 0;
                done = 0;
                count = 4'bxxxx;
                next_state = IDLE;
            end
        endcase
    end

    // Shift register to detect the pattern and load delay
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_reg <= 4'b0;
        end else if (state == SEARCH_PATTERN || state == LOAD_DELAY) begin
            shift_reg <= {shift_reg[2:0], data};
        end else begin
            shift_reg <= 4'b0;
        end
    end

    // Delay register to store the delay value
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            delay <= 4'b0;
        end else if (state == LOAD_DELAY && shift_reg[3:0] != 4'bxxxx) begin
            delay <= shift_reg[3:0];
        end
    end

    // Cycle counter for the counting delay
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            cycle_count <= 14'b0;
        end else if (state == COUNTING && cycle_count != 0) begin
            cycle_count <= cycle_count - 1;
        end else if (state == COUNTING && cycle_count == 0) begin
            cycle_count <= (delay + 1) * 1000;
        end else begin
            cycle_count <= 14'b0;
        end
    end

endmodule
