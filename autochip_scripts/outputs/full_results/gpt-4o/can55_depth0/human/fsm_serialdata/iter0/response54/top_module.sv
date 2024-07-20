module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    // State Encoding
    typedef enum reg [3:0] {
        IDLE = 4'b0000,
        START = 4'b0001,
        BIT_0 = 4'b0010,
        BIT_1 = 4'b0011,
        BIT_2 = 4'b0100,
        BIT_3 = 4'b0101,
        BIT_4 = 4'b0110,
        BIT_5 = 4'b0111,
        BIT_6 = 4'b1000,
        BIT_7 = 4'b1001,
        STOP = 4'b1010,
        ERROR = 4'b1011
    } state_t;

    state_t state, next_state;
    reg [7:0] byte_shift;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            out_byte <= 8'b0;
            done <= 1'b0;
            byte_shift <= 8'b0;
        end else begin
            state <= next_state;
            if (state == STOP && next_state == IDLE) begin
                out_byte <= byte_shift;
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
        end
    end

    always @(*) begin
        next_state = state;
        case (state)
            IDLE: begin
                if (in == 1'b0) next_state = START;
            end
            START: begin
                next_state = BIT_0;
            end
            BIT_0: next_state = BIT_1;
            BIT_1: next_state = BIT_2;
            BIT_2: next_state = BIT_3;
            BIT_3: next_state = BIT_4;
            BIT_4: next_state = BIT_5;
            BIT_5: next_state = BIT_6;
            BIT_6: next_state = BIT_7;
            BIT_7: next_state = STOP;
            STOP: begin
                if (in == 1'b1) next_state = IDLE;
                else next_state = ERROR;
            end
            ERROR: begin
                if (in == 1'b1) next_state = IDLE;
            end
        endcase
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            byte_shift <= 8'b0;
        end else begin
            case (state)
                BIT_0: byte_shift[0] <= in;
                BIT_1: byte_shift[1] <= in;
                BIT_2: byte_shift[2] <= in;
                BIT_3: byte_shift[3] <= in;
                BIT_4: byte_shift[4] <= in;
                BIT_5: byte_shift[5] <= in;
                BIT_6: byte_shift[6] <= in;
                BIT_7: byte_shift[7] <= in;
                default: byte_shift <= byte_shift;
            endcase
        end
    end

endmodule
