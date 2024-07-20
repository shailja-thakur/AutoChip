module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    typedef enum logic [2:0] {
        IDLE = 3'b000,
        START = 3'b001,
        DATA = 3'b010,
        STOP = 3'b011,
        ERROR = 3'b100
    } state_t;

    state_t state, next_state;
    reg [2:0] bit_count;
    reg [7:0] shift_reg;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_count <= 3'b000;
            done <= 0;
            out_byte <= 8'b00000000;
        end else begin
            state <= next_state;

            case (state)
                IDLE: begin
                    done <= 0;
                    bit_count <= 3'b000;
                end

                START: begin
                    bit_count <= 3'b000;
                end

                DATA: begin
                    shift_reg[bit_count] <= in;
                    bit_count <= bit_count + 1;
                end

                STOP: begin
                    out_byte <= shift_reg;
                    done <= 1;
                end

                ERROR: begin
                    done <= 0;
                end
            endcase
        end
    end

    always @(*) begin
        case (state)
            IDLE: begin
                if (!in)  // Start bit detected
                    next_state = START;
                else
                    next_state = IDLE;
            end

            START: begin
                if (bit_count == 3'b000)
                    next_state = DATA;
                else
                    next_state = START;
            end

            DATA: begin
                if (bit_count == 3'b111)
                    next_state = STOP;
                else
                    next_state = DATA;
            end

            STOP: begin
                if (in)  // Stop bit detected
                    next_state = IDLE;
                else
                    next_state = ERROR;
            end

            ERROR: begin
                if (in)
                    next_state = IDLE;
                else
                    next_state = ERROR;
            end

            default: next_state = IDLE;
        endcase
    end

endmodule
