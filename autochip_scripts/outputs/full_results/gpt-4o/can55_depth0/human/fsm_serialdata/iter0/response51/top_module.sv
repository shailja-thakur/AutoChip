module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);
    // State encoding
    typedef enum logic [2:0] {
        IDLE = 3'd0,
        START = 3'd1,
        DATA = 3'd2,
        STOP = 3'd3,
        DONE = 3'd4,
        ERROR = 3'd5
    } state_t;

    state_t state, next_state;
    reg [7:0] data_byte;
    reg [3:0] bit_counter;

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
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
                if (in == 0) begin
                    next_state = DATA;
                end else begin
                    next_state = IDLE;
                end
            end

            DATA: begin
                if (bit_counter == 4'd8) begin
                    next_state = STOP;
                end else begin
                    next_state = DATA;
                end
            end

            STOP: begin
                if (in == 1) begin
                    next_state = DONE;
                end else begin
                    next_state = ERROR;
                end
            end

            DONE: begin
                next_state = IDLE;
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

    // Output logic and bit counter
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            bit_counter <= 4'd0;
            out_byte <= 8'd0;
            done <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    bit_counter <= 4'd0;
                    done <= 1'b0;
                end

                START: begin
                    bit_counter <= 4'd0;
                end

                DATA: begin
                    data_byte[bit_counter] <= in;
                    bit_counter <= bit_counter + 1;
                end

                STOP: begin
                    out_byte <= data_byte;
                end

                DONE: begin
                    done <= 1'b1;
                end

                ERROR: begin
                    done <= 1'b0;
                end
            endcase
        end
    end

endmodule
