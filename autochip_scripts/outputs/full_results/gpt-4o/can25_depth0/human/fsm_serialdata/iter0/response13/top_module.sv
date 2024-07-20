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
        START_BIT = 3'b001,
        RECEIVE_DATA = 3'b010,
        STOP_BIT = 3'b011,
        DONE = 3'b100
    } state_t;

    state_t state, next_state;
    reg [2:0] bit_index;
    reg [7:0] data_byte;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_index <= 3'd0;
            data_byte <= 8'd0;
            out_byte <= 8'd0;
            done <= 1'b0;
        end else begin
            state <= next_state;

            case (next_state)
                START_BIT: begin
                    bit_index <= 3'd0;
                end

                RECEIVE_DATA: begin
                    data_byte[bit_index] <= in;
                    bit_index <= bit_index + 1;
                end

                DONE: begin
                    out_byte <= data_byte;
                    done <= 1'b1;
                end

                default: begin
                    done <= 1'b0;
                end
            endcase
        end
    end

    always @(*) begin
        case (state)
            IDLE: begin
                if (!in) 
                    next_state = START_BIT;
                else 
                    next_state = IDLE;
            end

            START_BIT: begin
                if (in == 1'b0)
                    next_state = RECEIVE_DATA;
                else
                    next_state = IDLE;
            end

            RECEIVE_DATA: begin
                if (bit_index == 3'd7)
                    next_state = STOP_BIT;
                else
                    next_state = RECEIVE_DATA;
            end

            STOP_BIT: begin
                if (in) 
                    next_state = DONE;
                else 
                    next_state = IDLE;
            end

            DONE: begin
                next_state = IDLE;
            end

            default: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule
