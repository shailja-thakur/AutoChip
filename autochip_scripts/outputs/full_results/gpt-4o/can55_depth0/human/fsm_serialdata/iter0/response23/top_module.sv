module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);
    typedef enum reg [2:0] {
        IDLE = 3'b000,
        START_BIT = 3'b001,
        DATA_BITS = 3'b010,
        STOP_BIT = 3'b011,
        ERROR = 3'b100
    } state_t;

    state_t state, next_state;
    reg [7:0] shift_reg;
    reg [3:0] bit_count;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            shift_reg <= 8'b0;
            bit_count <= 4'b0;
            out_byte <= 8'b0;
            done <= 1'b0;
        end else begin
            state <= next_state;

            case (next_state)
                IDLE: begin
                    done <= 1'b0;
                    bit_count <= 4'b0;
                end
                START_BIT: begin
                    // Wait for the entire start bit to pass
                end
                DATA_BITS: begin
                    shift_reg[bit_count] <= in;
                    bit_count <= bit_count + 4'b1;
                end
                STOP_BIT: begin
                    if (in == 1'b1) begin
                        out_byte <= shift_reg;
                        done <= 1'b1;
                    end else begin
                        done <= 1'b0;
                    end
                end
                ERROR: begin
                    done <= 1'b0;
                end
            endcase
        end
    end

    always @(*) begin
        case (state)
            IDLE: begin
                if (in == 1'b0) begin
                    next_state = START_BIT;
                end else begin
                    next_state = IDLE;
                end
            end
            START_BIT: begin
                if (bit_count == 4'b1) begin
                    next_state = DATA_BITS;
                end else begin
                    next_state = START_BIT;
                end
            end
            DATA_BITS: begin
                if (bit_count == 4'b1000) begin
                    next_state = STOP_BIT;
                end else begin
                    next_state = DATA_BITS;
                end
            end
            STOP_BIT: begin
                if (in == 1'b1) begin
                    next_state = IDLE;
                end else begin
                    next_state = ERROR;
                end
            end
            ERROR: begin
                if (in == 1'b1) begin
                    next_state = IDLE;
                end else begin
                    next_state = ERROR;
                end
            end
            default: next_state = IDLE;
        endcase
    end

endmodule
