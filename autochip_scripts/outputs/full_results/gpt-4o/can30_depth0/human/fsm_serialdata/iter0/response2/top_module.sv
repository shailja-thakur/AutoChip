module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    typedef enum logic [2:0] {
        IDLE    = 3'b000,
        START   = 3'b001,
        DATA    = 3'b010,
        STOP    = 3'b011,
        WAIT_STOP = 3'b100
    } state_t;

    state_t state, next_state;
    reg [2:0] bit_counter;
    reg [7:0] data_byte;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_counter <= 3'd0;
            data_byte <= 8'd0;
            done <= 1'b0;
        end else begin
            state <= next_state;

            if (state == DATA && bit_counter < 8) begin
                data_byte[bit_counter] <= in;
                bit_counter <= bit_counter + 1'b1;
            end

            if (state == STOP) begin
                out_byte <= data_byte;
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
        end
    end

    always_comb begin
        next_state = state;
        case (state)
            IDLE: begin
                if (in == 1'b0)        // Start bit detected
                    next_state = START;
            end
            START: begin
                next_state = DATA;
                bit_counter = 0;
            end
            DATA: begin
                if (bit_counter == 3'd7) // All 8 bits have been received
                    next_state = WAIT_STOP;
            end
            WAIT_STOP: begin
                if (in == 1'b1) // Stop bit detected
                    next_state = STOP;
            end
            STOP: begin
                next_state = IDLE; // Return to idle waiting for next byte
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule
