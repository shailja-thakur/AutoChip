module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // State definitions
    typedef enum logic [2:0] {
        IDLE = 3'd0,
        START = 3'd1,
        DATA = 3'd2,
        STOP = 3'd3,
        ERROR = 3'd4
    } state_t;

    state_t state, next_state;
    logic [2:0] bit_count;

    // State transition logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_count <= 3'd0;
        end else begin
            state <= next_state;
            if (state == DATA)
                bit_count <= bit_count + 3'd1;
            else if (state != DATA)
                bit_count <= 3'd0;
        end
    end

    // Next state logic
    always_comb begin
        done = 1'b0;
        next_state = state;

        case(state)
            IDLE: begin
                if (!in) // Start bit detected
                    next_state = START;
            end
            START: begin
                next_state = DATA;
            end
            DATA: begin
                if (bit_count == 3'd7) // Received 8 data bits
                    next_state = STOP;
            end
            STOP: begin
                if (in) begin // Stop bit detected
                    done = 1'b1;
                    next_state = IDLE;
                end else begin
                    next_state = ERROR; // Missing stop bit
                end
            end
            ERROR: begin
                if (in) // Wait for idle (stop bit)
                    next_state = IDLE;
            end
        endcase
    end

endmodule
