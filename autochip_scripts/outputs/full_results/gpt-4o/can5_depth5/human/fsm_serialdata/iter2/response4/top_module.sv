module top_module(
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    // State encoding
    typedef enum reg [2:0] {
        IDLE      = 3'b000,
        START_BIT = 3'b001,
        DATA_BITS = 3'b010,
        STOP_BIT  = 3'b011,
        FINISH    = 3'b100
    } state_t;

    state_t current_state, next_state;
    reg [2:0] bit_count;
    reg [7:0] shift_reg;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            bit_count <= 0;
            out_byte <= 0;
            done <= 0;
            shift_reg <= 0;
        end else begin
            current_state <= next_state;
            if (current_state == DATA_BITS && next_state == DATA_BITS) begin
                shift_reg[bit_count] <= in;
                bit_count <= bit_count + 1;
            end else if (current_state == DATA_BITS && next_state == STOP_BIT) begin
                shift_reg[bit_count] <= in;
            end

            if (current_state == STOP_BIT && next_state == FINISH) begin
                out_byte <= shift_reg;
                done <= 1;
            end else if (current_state == FINISH) begin
                done <= 0;
            end
        end
    end

    always @(*) begin
        next_state = current_state;
        case (current_state)
            IDLE: begin
                if (in == 0)
                    next_state = START_BIT;
            end
            START_BIT: begin
                next_state = DATA_BITS;
            end
            DATA_BITS: begin
                if (bit_count == 3'd7)
                    next_state = STOP_BIT;
            end
            STOP_BIT: begin
                if (in == 1)
                    next_state = FINISH;
                else
                    next_state = IDLE; // If stop bit is wrong, reset and wait for next byte
            end
            FINISH: begin
                next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end
endmodule
