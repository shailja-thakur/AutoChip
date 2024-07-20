module top_module (
    input clk,
    input in,
    input reset,
    output done
);

    // State definitions
    typedef enum logic[2:0] {
        IDLE    = 3'b000,
        START   = 3'b001,
        RECEIVE = 3'b010,
        STOP    = 3'b011,
        WAITSTOP= 3'b100
    } state_t;

    state_t state, next_state;
    logic [2:0] bit_count; // To count up to 8 data bits
    logic [7:0] data; // To store the received data

    // State transition logic
    always_ff @(posedge clk, posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic
    always_comb begin
        next_state = state; // Default to stay in the same state
        case (state)
            IDLE: begin
                if (in == 1'b0) // Detected start bit
                    next_state = START;
            end
            START: begin
                next_state = RECEIVE;
            end
            RECEIVE: begin
                if (bit_count == 3'd7)
                    next_state = STOP;
            end
            STOP: begin
                if (in == 1'b1) // Detected stop bit
                    next_state = IDLE;
                else
                    next_state = WAITSTOP;
            end
            WAITSTOP: begin
                if (in == 1'b1) // Wait until line goes idle
                    next_state = IDLE;
            end
        endcase
    end

    // Output logic
    assign done = (state == STOP && in == 1'b1);

    // Data bit counter and data storage logic
    always_ff @(posedge clk, posedge reset) begin
        if (reset) begin
            bit_count <= 3'd0;
            data <= 8'd0;
        end
        else begin
            case (state)
                RECEIVE: begin
                    bit_count <= bit_count + 3'd1;
                    data <= {in, data[7:1]}; // Shift in the received bit
                end
                default: bit_count <= 3'd0; // Reset bit count in other states
            endcase
        end
    end

endmodule
