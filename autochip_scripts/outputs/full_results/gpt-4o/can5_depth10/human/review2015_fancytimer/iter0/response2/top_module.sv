module top_module(
	input wire clk,
	input wire reset,
	input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    // State encoding
    typedef enum logic [2:0] {
        IDLE = 3'b000,
        DETECT_1 = 3'b001,
        DETECT_2 = 3'b010,
        DETECT_3 = 3'b011,
        DETECT_4 = 3'b100,
        LOAD_DELAY = 3'b101,
        COUNTING = 3'b110,
        DONE = 3'b111
    } state_t;

    state_t state, next_state;
    reg [3:0] delay;
    reg [14:0] timer;  // Maximum timer count is 15,000

    // Sequential logic for state transitions
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Combinational logic for next state and output logic
    always @(*) begin
        // Default assignments
        next_state = state;
        counting = 0;
        done = 0;
        count = 4'd0;

        case (state)
            IDLE: begin
                if (data) next_state = DETECT_1;
            end
            DETECT_1: begin
                if (data) next_state = DETECT_2;
                else next_state = IDLE;
            end
            DETECT_2: begin
                if (~data) next_state = DETECT_3;
                else next_state = IDLE;
            end
            DETECT_3: begin
                if (data) next_state = DETECT_4;
                else next_state = IDLE;
            end
            DETECT_4: begin
                if (~data) next_state = LOAD_DELAY;
                else next_state = IDLE;
            end
            LOAD_DELAY: begin
                next_state = COUNTING;
            end
            COUNTING: begin
                counting = 1;
                count = timer[14:10];  // Remaining time in terms of 1000 cycles
                if (timer == 0) next_state = DONE;
            end
            DONE: begin
                done = 1;
                if (ack) next_state = IDLE;
            end
        endcase
    end

    // Timer and delay register updates
    always @(posedge clk) begin
        if (reset) begin
            timer <= 0;
            delay <= 0;
        end else begin
            case (state)
                DETECT_4: begin
                    if (~data) delay <= {data, delay[3:1]};  // Shift in the delay bits MSB first
                end
                LOAD_DELAY: begin
                    timer <= (delay + 1) * 1000 - 1;
                end
                COUNTING: begin
                    if (timer > 0) timer <= timer - 1;
                end
            endcase
        end
    end

endmodule
