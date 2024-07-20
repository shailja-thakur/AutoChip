module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // State encoding
    typedef enum reg [2:0] {
        IDLE = 3'b000,
        START = 3'b001,
        DATA = 3'b010,
        STOP = 3'b011,
        ERROR = 3'b100
    } state_t;
    
    // State and data bit counter
    state_t state, next_state;
    reg [2:0] bit_count;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_count <= 3'b000;
        end else begin
            state <= next_state;
            if (state == DATA)
                bit_count <= bit_count + 3'b001;
            else
                bit_count <= 3'b000;
        end
    end

    always @(*) begin
        next_state = state; // Default to hold state
        done = 1'b0;

        case (state)
            IDLE: begin
                if (!in) // Start bit detected
                    next_state = START;
            end

            START: begin
                next_state = DATA; // Move to data reception state
            end

            DATA: begin
                if (bit_count == 3'b111) // All 8 data bits received
                    next_state = STOP;
            end

            STOP: begin
                if (in) begin
                    done = 1'b1; // Correct stop bit detected
                    next_state = IDLE;
                end else begin
                    next_state = ERROR; // Invalid stop bit
                end
            end

            ERROR: begin
                if (in) // Wait for high line to return to idle state
                    next_state = IDLE;
            end
        endcase
    end
endmodule
