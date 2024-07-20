module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // State encoding
    typedef enum reg [2:0] {
        IDLE = 3'b000,
        START = 3'b001,
        DATA = 3'b010,
        STOP = 3'b011,
        ERROR = 3'b100
    } state_t;

    state_t state, next_state;
    reg [3:0] bit_counter;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            bit_counter <= 0;
            done <= 0;
        end else begin
            state <= next_state;
            if (state == DATA) begin
                bit_counter <= bit_counter + 1;
            end else if (state != DATA) begin
                bit_counter <= 0;
            end
            
            if (state == STOP && in) begin
                done <= 1;
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
                if (bit_counter == 8) begin
                    next_state = in ? STOP : ERROR;
                end else begin
                    next_state = DATA;
                end
            end

            STOP: begin
                if (in) begin
                    next_state = IDLE;
                end else begin
                    next_state = ERROR;
                end
            end

            ERROR: begin
                if (in == 1) begin
                    next_state = IDLE;
                end else begin
                    next_state = ERROR;
                end
            end

            default: begin
                next_state = IDLE;
            end
        endcase
    end
endmodule
