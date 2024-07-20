module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

    // State enumeration
    typedef enum logic [2:0] {
        IDLE = 3'b000,
        DETECT_1 = 3'b001,
        DETECT_11 = 3'b010,
        DETECT_110 = 3'b011,
        DETECT_1101 = 3'b100,
        SHIFT_DELAY = 3'b101,
        COUNT_DOWN = 3'b110,
        DONE = 3'b111
    } state_t;

    state_t state, next_state;

    reg [3:0] delay;
    reg [15:0] cycle_count;

    // State Transition Logic
    always @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next State Logic
    always @(*) begin
        next_state = state;
        case (state)
            IDLE: if (data) next_state = DETECT_1;
            DETECT_1: if (data) next_state = DETECT_11; else next_state = IDLE;
            DETECT_11: if (~data) next_state = DETECT_110; else next_state = IDLE;
            DETECT_110: if (data) next_state = DETECT_1101; else next_state = IDLE;
            DETECT_1101: next_state = SHIFT_DELAY;
            SHIFT_DELAY: if (delay_shift_done) next_state = COUNT_DOWN;
            COUNT_DOWN: if (cycle_count == 0) next_state = DONE;
            DONE: if (ack) next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

    // Datapath Logic
    reg [2:0] bit_count;
    reg delay_shift_done;
    reg shift_reg;

    always @(posedge clk) begin
        if (reset) begin
            delay <= 4'd0;
            bit_count <= 3'd0;
            delay_shift_done <= 1'b0;
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    bit_count <= 3'd0;
                    delay_shift_done <= 1'b0;
                    counting <= 1'b0;
                    done <= 1'b0;
                end
                DETECT_1: ;
                DETECT_11: ;
                DETECT_110: ;
                DETECT_1101: begin
                    delay <= 4'd0;
                    bit_count <= 3'd0;
                end
                SHIFT_DELAY: begin
                    if (bit_count < 4) begin
                        delay <= {delay[2:0], data};
                        bit_count <= bit_count + 1;
                    end else begin
                        delay_shift_done <= 1'b1;
                    end
                end
                COUNT_DOWN: begin
                    counting <= 1'b1;
                    if (cycle_count == 0) begin
                        if (count > 0) begin
                            count <= count - 1;
                            cycle_count <= 16'd999;
                        end else begin
                            counting <= 1'b0;
                            done <= 1'b1;
                        end
                    end else begin
                        cycle_count <= cycle_count - 1;
                    end
                end
                DONE: begin
                    if (ack) begin
                        done <= 1'b0;
                    end
                end
            endcase
        end
    end

    // Cycle count initialization
    always @(posedge clk) begin
        if (state == SHIFT_DELAY && next_state == COUNT_DOWN) begin
            cycle_count <= (delay + 1) * 1000;
            count <= delay;
        end
    end

endmodule
