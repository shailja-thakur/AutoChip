module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

    // State Encoding
    typedef enum logic [2:0] {
        SEARCH = 3'b000,
        LOAD_DURATION = 3'b001,
        COUNTING = 3'b010,
        DONE = 3'b011
    } state_t;
    
    state_t state, next_state;
    reg [3:0] shift_reg;
    reg [2:0] bit_count;
    reg [12:0] timer; // 13 bits to count up to 8000 cycles (maximum delay is 7, so maximum count is (7+1)*1000 = 8000)
    reg [3:0] delay;

    // State Transition
    always_ff @(posedge clk) begin
        if (reset) 
            state <= SEARCH;
        else 
            state <= next_state;
    end

    // Next State Logic and Timer Control Logic
    always_comb begin
        next_state = state;
        counting = 0;
        done = 0;
        case (state)
            SEARCH: begin
                if (shift_reg == 4'b1101 && bit_count == 3) begin
                    next_state = LOAD_DURATION;
                end
            end
            LOAD_DURATION: begin
                if (bit_count == 7) begin
                    next_state = COUNTING;
                    delay = shift_reg[3:0];
                end
            end
            COUNTING: begin
                counting = 1;
                if (timer == 0) begin
                    next_state = DONE;
                end
            end
            DONE: begin
                done = 1;
                if (ack) begin
                    next_state = SEARCH;
                end
            end
            default: next_state = SEARCH;
        endcase
    end

    // Data Shift Register
    always_ff @(posedge clk) begin
        if (reset) begin
            shift_reg <= 4'b0;
            bit_count <= 0;
        end
        else if (state == SEARCH || state == LOAD_DURATION) begin
            shift_reg <= {shift_reg[2:0], data}; // Shift left and input new data bit
            bit_count <= bit_count + 1;
        end
        else begin
            bit_count <= 0;
        end
    end

    // Timer Logic
    always_ff @(posedge clk) begin
        if (reset) begin
            timer <= 0;
        end
        else if (state == COUNTING) begin
            if (timer == 0) begin
                if (delay != 0) begin
                    timer <= 1000; // Set the timer for the next 1000 cycles
                    delay <= delay - 1;
                end
            end
            else begin
                timer <= timer - 1;
            end
        end
        else if (state != COUNTING) begin
            timer <= (delay + 1) * 1000; // Initialize the timer
        end
    end

    // Count Output 
    always_ff @(posedge clk) begin
        if (reset || state == DONE || state == SEARCH) begin
            count <= 4'bxxxx; // Don't care
        end
        else if (state == COUNTING) begin
            if (timer % 1000 == 0) begin
                count <= delay;
            end
        end
    end
endmodule
