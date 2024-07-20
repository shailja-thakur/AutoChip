module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    // Parameters for state machine states
    typedef enum logic [2:0] {
        IDLE = 3'b000,
        START = 3'b001,
        DATA = 3'b010,
        STOP = 3'b011,
        ERROR = 3'b100
    } state_t;

    state_t current_state, next_state;
    reg [3:0] bit_count;
    reg [7:0] data_byte;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            bit_count <= 0;
            data_byte <= 8'b0;
            done <= 0;
        end
        else begin
            current_state <= next_state;

            if (next_state == DATA || next_state == STOP) begin
                data_byte[bit_count] <= in;
                bit_count <= bit_count + 1;
            end

            if (next_state == STOP) begin
                out_byte <= data_byte;
                done <= 1;
            end else begin
                done <= 0;
            end
        end
    end

    always_comb begin
        next_state = current_state;
        case (current_state)
            IDLE: begin
                if (in == 0) // Start bit detected
                    next_state = START;
            end
            START: begin
                if (bit_count == 0) // Wait for Start bit to be stable
                    next_state = DATA;
            end
            DATA: begin
                if (bit_count == 8) // All data bits received
                    next_state = STOP;
            end
            STOP: begin
                if (in == 1) // Stop bit detected
                    next_state = IDLE;
                else // Incorrect Stop bit
                    next_state = ERROR;
            end
            ERROR: begin
                if (in == 1) // Wait for line to be idle
                    next_state = IDLE;
            end
        endcase
    end
endmodule
