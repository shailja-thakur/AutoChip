module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    // State encoding
    typedef enum reg [2:0] {
        IDLE = 3'b000,
        START = 3'b001,
        DATA = 3'b010,
        STOP = 3'b011,
        WAIT_STOP = 3'b100
    } state_t;
    state_t state, next_state;

    reg [2:0] bit_count;
    reg [7:0] data_shift;

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_count <= 3'b000;
            data_shift <= 8'b0;
            out_byte <= 8'b0;
            done <= 0;
        end else begin
            state <= next_state;
            if (state == DATA) begin
                data_shift <= {in, data_shift[7:1]};
                bit_count <= bit_count + 1;
            end else if (state == STOP) begin
                out_byte <= data_shift;
            end else if (state == START || state == IDLE) begin
                bit_count <= 3'b000;
            end
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            IDLE: begin
                done = 0;
                if (~in) begin
                    next_state = START;
                end else begin
                    next_state = IDLE;
                end
            end
            START: begin
                done = 0;
                next_state = DATA;
            end
            DATA: begin
                done = 0;
                if (bit_count == 3'b111) begin
                    next_state = STOP;
                end else begin
                    next_state = DATA;
                end
            end
            STOP: begin
                if (in) begin
                    done = 1;
                    next_state = IDLE;
                end else begin
                    done = 0;
                    next_state = WAIT_STOP;
                end
            end
            WAIT_STOP: begin
                done = 0;
                if (in) begin
                    next_state = IDLE;
                end else begin
                    next_state = WAIT_STOP;
                end
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule
