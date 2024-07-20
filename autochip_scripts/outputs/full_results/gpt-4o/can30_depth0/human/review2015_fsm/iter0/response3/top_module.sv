module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack
);

    // State encoding
    typedef enum logic [2:0] {
        IDLE = 3'b000,
        DETECT_1 = 3'b001,
        DETECT_11 = 3'b010,
        DETECT_110 = 3'b011,
        DETECT_1101 = 3'b100,
        SHIFT = 3'b101,
        COUNT = 3'b110,
        WAIT_ACK = 3'b111
    } state_t;
 
    state_t state, next_state;
    reg [2:0] shift_count;  // 3-bit counter to track the 4 clock cycles

    // State transition logic (sequential)
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            shift_count <= 3'b000;
        end else begin
            state <= next_state;
            if (state == SHIFT) begin
                if (shift_count < 3'd4) begin
                    shift_count <= shift_count + 3'b001;
                end else begin
                    shift_count <= 3'b000;  // reset shift_count
                end
            end
        end
    end

    // Next state logic (combinational)
    always_comb begin
        case (state)
            IDLE: begin
                if (data) begin
                    next_state = DETECT_1;
                end else begin
                    next_state = IDLE;
                end
            end
            DETECT_1: begin
                if (data) begin
                    next_state = DETECT_11;
                end else begin
                    next_state = IDLE;
                end
            end
            DETECT_11: begin
                if (data == 0) begin
                    next_state = DETECT_110;
                end else begin
                    next_state = IDLE;
                end
            end
            DETECT_110: begin
                if (data) begin
                    next_state = DETECT_1101;
                end else begin
                    next_state = IDLE;
                end
            end
            DETECT_1101: begin
                next_state = SHIFT;
            end
            SHIFT: begin
                if (shift_count < 3'd4) begin
                    next_state = SHIFT;
                end else begin
                    next_state = COUNT;
                end
            end
            COUNT: begin
                if (done_counting) begin
                    next_state = WAIT_ACK;
                end else begin
                    next_state = COUNT;
                end
            end
            WAIT_ACK: begin
                if (ack) begin
                    next_state = IDLE;
                end else begin
                    next_state = WAIT_ACK;
                end
            end
            default: next_state = IDLE;
        endcase
    end

    // Output logic (combinational)
    always_ff @(posedge clk) begin
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;

        case (state)
            SHIFT: shift_ena = 1'b1;
            COUNT: counting = 1'b1;
            WAIT_ACK: done = 1'b1;
            default: begin
                shift_ena = 1'b0;
                counting = 1'b0;
                done = 1'b0;
            end
        endcase
    end

endmodule
