module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    typedef enum reg [2:0] {
        IDLE = 3'b000,
        START = 3'b001,
        DATA = 3'b010,
        STOP = 3'b011,
        DONE = 3'b100
    } state_t;

    state_t state, next_state;
    reg [2:0] bit_cnt;
    reg [7:0] byte_data;

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_cnt <= 3'd0;
            out_byte <= 8'd0;
            byte_data <= 8'd0;
            done <= 0;
        end else begin
            state <= next_state;
            if (state == DATA) begin
                byte_data[bit_cnt] <= in;
                bit_cnt <= bit_cnt + 3'd1;
            end
            if (state == IDLE || state == DONE) begin
                bit_cnt <= 3'd0;
            end
            if (state == DONE) begin
                done <= 1;
                out_byte <= byte_data;
            end else begin
                done <= 0;
            end
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (in == 0) begin
                    next_state = START;
                end else begin
                    next_state = IDLE;
                end
            end
            START: begin
                next_state = DATA;
            end
            DATA: begin
                if (bit_cnt == 3'd7) begin
                    next_state = STOP;
                end else begin
                    next_state = DATA;
                end
            end
            STOP: begin
                if (in == 1) begin
                    next_state = DONE;
                end else begin
                    next_state = IDLE;
                end
            end
            DONE: begin
                if (in == 1) begin
                    next_state = IDLE;
                end else begin
                    next_state = DONE;
                end
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule
