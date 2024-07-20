module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack);

    // State encoding
    typedef enum logic [2:0] {
        S_IDLE = 3'b000,
        S_SEARCH = 3'b001,
        S_LOAD = 3'b010,
        S_COUNT = 3'b011,
        S_DONE = 3'b100
    } state_t;

    reg [2:0] state, next_state;
    reg [3:0] pattern_shift;
    reg [3:0] delay;
    reg [15:0] counter; // 16-bit counter to count up to 16000 cycles
    wire start_detected;

    // Shift register to detect the start pattern 1101
    always @(posedge clk) begin
        if (reset)
            pattern_shift <= 4'b0000;
        else if (state == S_SEARCH)
            pattern_shift <= {pattern_shift[2:0], data};
    end

    assign start_detected = (pattern_shift == 4'b1101);

    // State transition logic
    always @(posedge clk) begin
        if (reset)
            state <= S_IDLE;
        else
            state <= next_state;
    end

    always @(*) begin
        next_state = state;
        counting = 1'b0;
        done = 1'b0;

        case (state)
            S_IDLE: begin
                next_state = S_SEARCH;
            end
            S_SEARCH: begin
                if (start_detected)
                    next_state = S_LOAD;
            end
            S_LOAD: begin
                next_state = S_COUNT;
            end
            S_COUNT: begin
                counting = 1'b1;
                if (counter == 16'd0)
                    next_state = S_DONE;
            end
            S_DONE: begin
                done = 1'b1;
                if (ack)
                    next_state = S_SEARCH; // reset and look for the next start sequence
            end
        endcase
    end

    // Load delay and initialize counter
    always @(posedge clk) begin
        if (reset) begin
            delay <= 4'd0;
            counter <= 16'd0;
        end else case (state)
            S_LOAD: begin
                delay <= {pattern_shift[2:0], data};
                counter <= ({pattern_shift[2:0], data} + 4'd1) * 16'd1000;
            end
            S_COUNT: begin
                if (counter != 16'd0)
                    counter <= counter - 16'd1;
            end
        endcase
    end

    assign count = counter[15:12];

endmodule
