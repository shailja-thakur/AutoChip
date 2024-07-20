module top_module (
    input clk,
    input in,
    input reset,
    output done
);

// Define states of the FSM
typedef enum logic [2:0] {
    IDLE,
    START_BIT,
    DATA_BITS,
    STOP_BIT
} state_t;

// Define signals for FSM
reg [2:0] state;
reg start_bit;
reg [7:0] data;
reg stop_bit;
reg done;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        // Reset FSM to IDLE state
        state <= IDLE;
        start_bit <= 0;
        data <= 0;
        stop_bit <= 1;
        done <= 0;
    end else begin
        case (state)
            IDLE:
                if (in == 1'b0) begin
                    // Detect start bit
                    state <= START_BIT;
                end
            START_BIT:
                if (in == 1'b0) begin
                    // Start bit detected, initialize data
                    start_bit <= 1;
                    data <= 0;
                    state <= DATA_BITS;
                end
            DATA_BITS:
                // Shift in data bits
                data <= {data[6:0], in};
                if (start_bit && data[7] == 1'b1) begin
                    // Unexpected stop bit, wait until stop bit is received again
                    state <= STOP_BIT;
                end else if (!start_bit && data[7] == 1'b0) begin
                    // Stop bit detected, set done signal and go back to IDLE state
                    done <= 1;
                    state <= IDLE;
                end
            STOP_BIT:
                if (in == 1'b1) begin
                    // Stop bit detected, go back to IDLE state
                    state <= IDLE;
                end
        endcase
    end
end

endmodule
