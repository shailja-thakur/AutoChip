module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    typedef enum reg [2:0] {
        IDLE = 3'b000,
        START = 3'b001,
        DATA = 3'b010,
        STOP = 3'b011,
        ERROR = 3'b100
    } state_t;

    reg [2:0] current_state, next_state;
    reg [2:0] bit_counter;
    reg [7:0] data_byte;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            bit_counter <= 3'b000;
            done <= 1'b0;
        end
        else begin
            current_state <= next_state;
            if (current_state == START || current_state == DATA) begin
                bit_counter <= bit_counter + 1;
            end
            if (current_state == STOP && in == 1'b1) begin
                done <= 1'b1;
            end
        end
    end

    always @(*) begin
        case(current_state)
            IDLE: begin
                done = 1'b0;
                if (in == 1'b0) begin
                    next_state = START;
                end
                else begin
                    next_state = IDLE;
                end
            end

            START: begin
                if (bit_counter == 3'b000) begin
                    next_state = DATA;
                end
                else begin
                    next_state = START;
                end
            end

            DATA: begin
                if (bit_counter == 3'b111) begin
                    next_state = STOP;
                end
                else begin
                    next_state = DATA;
                end
            end

            STOP: begin
                if (in == 1'b1) begin
                    next_state = IDLE;
                end
                else begin
                    next_state = ERROR;
                end
            end

            ERROR: begin
                done = 1'b0;
                if (in == 1'b1) begin
                    next_state = IDLE;
                end
                else begin
                    next_state = ERROR;
                end
            end

            default: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule
