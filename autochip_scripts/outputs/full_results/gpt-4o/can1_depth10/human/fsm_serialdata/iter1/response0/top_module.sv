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
        DATA,
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
                    if (in == 1'b0) begin
                        next_state <= START;
                    end
                end

                START: begin
                    bit_cnt <= 3'b0;
                    next_state <= DATA;
                end

                DATA: begin
                    shift_reg[bit_cnt] <= in;
                    bit_cnt <= bit_cnt + 1;
                    if (bit_cnt == 7) begin
                        next_state <= STOP;
                    end
                end

                STOP: begin
                    if (in == 1'b1) begin
                        out_byte <= shift_reg;
                        done <= 1'b1;
                        next_state <= IDLE;
                    end else begin
                        next_state <= IDLE;
                    end
                end

                default: begin
                    next_state <= IDLE;
                end
            endcase
        end
    end

    always @(*) begin
        case (state)
            IDLE: begin
                if (in == 1'b0)
                    next_state = START;
                else
                    next_state = IDLE;
            end
            
            START: begin
                next_state = DATA;
            end
            
            DATA: begin
                if (bit_cnt == 7)
                    next_state = STOP;
                else
                    next_state = DATA;
            end
            
            STOP: begin
                if (in == 1'b1)
                    next_state = IDLE;
                else
                    next_state = IDLE;
            end
            
            default: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule
