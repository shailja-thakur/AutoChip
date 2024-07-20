module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);
    // FSM States
    typedef enum reg [2:0] {
        IDLE = 3'b000,
        START = 3'b001,
        RECEIVE = 3'b010,
        STOP = 3'b011,
        ERROR = 3'b100
    } state_t;

    state_t state, next_state;
    reg [2:0] bit_counter;
    reg [7:0] data_bits;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            out_byte <= 8'b0;
            done <= 1'b0;
            bit_counter <= 3'b0;
            data_bits <= 8'b0;
        end else begin
            state <= next_state;
            bit_counter <= (next_state == START) ? 3'b0 : 
                            (next_state == RECEIVE) ? bit_counter + 1'b1 : 
                            bit_counter;
            if (state == RECEIVE) begin
                data_bits[bit_counter] <= in; // Shift in bits
            end
            if (next_state == STOP && state == RECEIVE) begin
                out_byte <= data_bits; // Load the received byte
            end
            done <= (next_state == STOP);
        end
    end

    always @(*) begin
        case (state)
            IDLE: begin
                if (in == 1'b0) // Start bit detected
                    next_state = START;
                else
                    next_state = IDLE;
            end
            START: begin
                if (in == 1'b0) // Confirm start bit remains low
                    next_state = RECEIVE;
                else
                    next_state = IDLE;
            end
            RECEIVE: begin
                if (bit_counter == 3'b111)
                    next_state = STOP; // After 8 bits, expect stop bit
                else
                    next_state = RECEIVE;
            end
            STOP: begin
                if (in == 1'b1) // Stop bit detected
                    next_state = IDLE;
                else
                    next_state = ERROR; // Stop bit not detected, enter ERROR state
            end
            ERROR: begin
                if (in == 1'b1) // Wait until line is idle before restarting
                    next_state = IDLE;
                else
                    next_state = ERROR;
            end
            default: next_state = IDLE;
        endcase
    end

endmodule
