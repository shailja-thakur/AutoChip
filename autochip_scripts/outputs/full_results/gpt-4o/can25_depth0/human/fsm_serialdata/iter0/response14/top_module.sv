module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    // State enumeration
    typedef enum logic [2:0] {
        IDLE,
        START,
        DATA,
        STOP
    } state_t;

    state_t state, next_state;
    reg [2:0] bit_count;
    reg [7:0] data;

    // FSM state transition logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_count <= 0;
            data <= 0;
            out_byte <= 0;
            done <= 0;
        end
        else begin
            state <= next_state;
            if (state == DATA) begin
                data[bit_count] <= in;
                bit_count <= bit_count + 1;
            end
            else if (state == STOP || state == IDLE) begin
                bit_count <= 0;
            end
        end
    end

    // Next state logic
    always_comb begin
        next_state = state; // Default to staying in the same state
        done = 0;

        case (state)
            IDLE: begin
                if (in == 0) // Start bit detected
                    next_state = START;
            end
            START: begin
                next_state = DATA;
            end
            DATA: begin
                if (bit_count == 7)
                    next_state = STOP;
            end
            STOP: begin
                if (in == 1) begin // Stop bit detected
                    done = 1;
                    next_state = IDLE;
                    out_byte = data;
                end
                else begin
                    // If the stop bit wasn't detected correctly, stay in STOP state until it is
                    next_state = STOP;
                end
            end
        endcase
    end

endmodule
