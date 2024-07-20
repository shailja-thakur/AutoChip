module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);
    // State encoding
    typedef enum reg [2:0] {
        IDLE       = 3'b000,
        START_BIT  = 3'b001,
        RECEIVE_0  = 3'b010,
        RECEIVE_1  = 3'b011,
        RECEIVE_2  = 3'b100,
        RECEIVE_3  = 3'b101,
        RECEIVE_4  = 3'b110,
        RECEIVE_5  = 3'b111,
        RECEIVE_6  = 3'b000,
        RECEIVE_7  = 3'b001,
        STOP_BIT   = 3'b010
    } state_t;

    state_t current_state, next_state;
    reg [2:0] bit_count;

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            bit_count <= 3'b000;
        end else begin
            current_state <= next_state;
            if (current_state == START_BIT || current_state[2] == 1'b1)
                bit_count <= bit_count + 1;
            else
                bit_count <= 3'b000;
        end
    end

    // Next state logic
    always @* begin
        case (current_state)
            IDLE:       next_state = (in == 1'b0) ? START_BIT : IDLE;
            START_BIT:  next_state = (bit_count == 3'b111) ? RECEIVE_0 : START_BIT;
            RECEIVE_0:  next_state = RECEIVE_1;
            RECEIVE_1:  next_state = RECEIVE_2;
            RECEIVE_2:  next_state = RECEIVE_3;
            RECEIVE_3:  next_state = RECEIVE_4;
            RECEIVE_4:  next_state = RECEIVE_5;
            RECEIVE_5:  next_state = RECEIVE_6;
            RECEIVE_6:  next_state = RECEIVE_7;
            RECEIVE_7:  next_state = STOP_BIT;
            STOP_BIT:   next_state = (in == 1'b1) ? IDLE : START_BIT;
            default:    next_state = IDLE;
        endcase
    end

    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            done <= 0;
        end else if (current_state == STOP_BIT && in == 1'b1) begin
            done <= 1;
        end else begin
            done <= 0;
        end
    end
endmodule
