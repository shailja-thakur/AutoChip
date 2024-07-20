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
    reg [2:0] bit_count;
    reg [7:0] data_reg;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_count <= 3'b0;
            out_byte <= 8'b0;
            done <= 1'b0;
        end else begin
            state <= next_state;
            case (state)
                IDLE: begin
                    done <= 1'b0;
                end
                DATA_BITS: begin
                    data_reg[bit_count] <= in;
                    if (bit_count == 3'd7) begin
                        out_byte <= data_reg;
                    end
                end
                STOP_BIT: begin
                    if (in == 1'b1) begin
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
        next_state = state;
        case (state)
            IDLE: begin
                if (in == 1'b0) begin
                    next_state = START_BIT;
                end
            end
            START_BIT: begin
                if (in == 1'b0) begin
                    next_state = DATA_BITS;
                    bit_count = 3'b0;
                end else begin
                    next_state = IDLE;
                end
            end
            DATA_BITS: begin
                if (bit_count == 3'd7) begin
                    next_state = STOP_BIT;
                end else begin
                    next_state = DATA_BITS;
                    bit_count = bit_count + 1;
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
                end
            end
        endcase
    end

endmodule
