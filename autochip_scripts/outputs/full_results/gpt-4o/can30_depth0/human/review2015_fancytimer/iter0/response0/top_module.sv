module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    // State Declarations
    typedef enum logic [2:0] {
        IDLE = 3'b000,
        DETECT_1 = 3'b001,
        DETECT_11 = 3'b010,
        DETECT_110 = 3'b011,
        DETECT_1101 = 3'b100,
        READ_DELAY = 3'b101,
        COUNTDOWN = 3'b110,
        DONE = 3'b111
    } state_t;

    reg [2:0] state, next_state;
    reg [3:0] delay, delay_count;
    reg [11:0] counter; // For counting up to 1000 cycles (12 bits to cover up to 6000 cycles)
    reg [3:0] shift_register;

    // State Machine
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            counting <= 0;
            done <= 0;
        end else begin
            state <= next_state;
        end
    end

    // Next State Logic and Outputs
    always @(*) begin
        next_state = state;
        case (state)
            IDLE: begin
                if (data == 1) next_state = DETECT_1;
                counting = 0;
                done = 0;
            end
            DETECT_1: next_state = data ? DETECT_11 : IDLE;
            DETECT_11: next_state = data ? DETECT_110 : IDLE;
            DETECT_110: next_state = data ? DETECT_1101 : IDLE;
            DETECT_1101: next_state = READ_DELAY;

            READ_DELAY: begin
                if (shift_register[3] == 4'b1111) next_state = COUNTDOWN;
            end

            COUNTDOWN: begin
                if (counter == 1000) begin
                    if (delay_count == 0) next_state = DONE;
                    else next_state = COUNTDOWN;
                end
                counting = 1;
                done = 0;
            end

            DONE: begin
                counting = 0;
                if (ack) next_state = IDLE;
                done = 1;
            end
        endcase
    end

    // Shift Register and Delay Capture
    always @(posedge clk) begin
        if (state == READ_DELAY) begin
            shift_register <= {shift_register[2:0], data};

            if (shift_register[3] == 1'b1) begin
                delay <= shift_register;
                delay_count <= delay;
                counter <= 0;
            end
        end
    end

    // Countdown Logic
    always @(posedge clk) begin
        if (state == COUNTDOWN) begin
            if (counter == 1000) begin
                counter <= 0;
                if (delay_count > 0) delay_count <= delay_count - 1;
            end else begin
                counter <= counter + 1;
            end
        end
    end

    assign count = (counting) ? delay_count : 4'dx; // count is only valid when counting

endmodule
