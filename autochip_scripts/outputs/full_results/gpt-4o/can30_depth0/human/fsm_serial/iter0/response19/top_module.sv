module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // State Encoding
    typedef enum reg [2:0] {
        IDLE    = 3'b000,
        START   = 3'b001,
        DATA    = 3'b010,
        STOP    = 3'b011,
        ERROR   = 3'b100
    } state_t;

    state_t current_state, next_state;
    reg [2:0] bit_count; // 3 bits to count from 0 to 7 (for the 8 data bits)

    // State Register
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            bit_count <= 3'd0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == DATA) begin
                bit_count <= bit_count + 1'b1;
            end else if (current_state != DATA) begin
                bit_count <= 3'd0;
            end

            done <= (current_state == STOP) && in;
        end
    end

    // Next State Logic
    always @(*) begin
        next_state = current_state;
        case (current_state)
            IDLE: begin
                if (in == 1'b0) begin // Waiting for start bit (0)
                    next_state = START;
                end
            end
            START: begin
                next_state = DATA; // Move to DATA state to receive 8 bits
            end
            DATA: begin
                if (bit_count == 3'd7) begin
                    next_state = STOP; // After 8 bits, move to STOP state
                end
            end
            STOP: begin
                if (in == 1'b1) begin // Waiting for stop bit (1)
                    next_state = IDLE; // Successfully received byte, go back to IDLE
                end else begin
                    next_state = ERROR; // Stop bit not detected, move to ERROR
                end
            end
            ERROR: begin
                if (in == 1'b1) begin
                    next_state = IDLE; // Stop bit finally detected, move back to IDLE
                end
            end
        endcase
    end
endmodule
