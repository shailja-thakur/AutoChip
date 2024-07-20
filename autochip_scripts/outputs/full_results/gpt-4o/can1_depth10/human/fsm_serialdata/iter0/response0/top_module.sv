module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    // FSM states
    typedef enum reg [3:0] {
        IDLE,
        START,
        DATA0,
        DATA1,
        DATA2,
        DATA3,
        DATA4,
        DATA5,
        DATA6,
        DATA7,
        STOP
    } state_t;

    state_t state, next_state;
    reg [7:0] shift_reg;
    reg [2:0] bit_cnt;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            shift_reg <= 8'b0;
            bit_cnt <= 3'b0;
            out_byte <= 8'b0;
            done <= 1'b0;
        end else begin
            state <= next_state;

            case (state)
                IDLE: begin
                    done <= 1'b0;
                end

                START: begin
                    bit_cnt <= 3'b0;
                end

                DATA0, DATA1, DATA2, DATA3, DATA4, DATA5, DATA6, DATA7: begin
                    shift_reg[bit_cnt] <= in;
                    bit_cnt <= bit_cnt + 1;
                end

                STOP: begin
                    if (in == 1'b1) begin
                        out_byte <= shift_reg;
                        done <= 1'b1;
                    end else begin
                        done <= 1'b0;
                    end
                end

                default: begin
                    done <= 1'b0;
                end
            endcase
        end
    end

    always @(*) begin
        case (state)
            IDLE:
                if (in == 1'b0)
                    next_state = START;
                else
                    next_state = IDLE;

            START:
                next_state = DATA0;

            DATA0:
                next_state = DATA1;

            DATA1:
                next_state = DATA2;

            DATA2:
                next_state = DATA3;

            DATA3:
                next_state = DATA4;

            DATA4:
                next_state = DATA5;

            DATA5:
                next_state = DATA6;

            DATA6:
                next_state = DATA7;

            DATA7:
                next_state = STOP;

            STOP:
                if (in == 1'b1)
                    next_state = IDLE;
                else
                    next_state = STOP;

            default:
                next_state = IDLE;
        endcase
    end
endmodule
