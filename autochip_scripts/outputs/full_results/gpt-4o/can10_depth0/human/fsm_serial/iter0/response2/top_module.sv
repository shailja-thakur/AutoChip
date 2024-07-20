module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // State declaration
    typedef enum logic [2:0] {
        IDLE = 3'b000,
        START = 3'b001,
        DATA = 3'b010,
        STOP = 3'b011,
        ERROR = 3'b100
    } state_t;

    state_t current_state, next_state;
    reg [2:0] bit_count;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            bit_count <= 3'd0;
        end else begin
            current_state <= next_state;
            if (current_state == DATA)
                bit_count <= bit_count + 1;
            else
                bit_count <= 3'd0;
        end
    end

    always_comb begin
        next_state = current_state; // Default state is to stay in current state
        done = 1'b0; // Default output is 0

        case (current_state)
            IDLE: begin
                if (in == 1'b0)
                    next_state = START; // Detected start bit (0)
            end

            START: begin
                next_state = DATA; // Move to DATA state
            end

            DATA: begin
                if (bit_count == 3'd7)
                    next_state = STOP; // After collecting 8 data bits, move to STOP state
            end

            STOP: begin
                if (in == 1'b1) begin
                    next_state = IDLE; // Valid stop bit (1), go back to IDLE
                    done = 1'b1; // Indicate byte received
                end else
                    next_state = ERROR; // Invalid stop bit, go to ERROR state
            end

            ERROR: begin
                if (in == 1'b1)
                    next_state = IDLE; // Wait for idle state (1) to start over
            end

            default: next_state = IDLE; // Default to IDLE state
        endcase
    end

endmodule
