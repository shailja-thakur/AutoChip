module top_module (
    input clk,
    input in,
    input reset,
    output done
);

    // Define states
    typedef enum logic [2:0] {
        IDLE,
        START_BIT,
        DATA_BITS,
        STOP_BIT
    } state_t;

    // Define signals
    logic [2:0] state;
    logic [7:0] data;
    logic start_bit_detected;
    logic stop_bit_detected;

    // FSM
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            data <= 8'b0;
            start_bit_detected <= 1'b0;
            stop_bit_detected <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    if (in == 1'b0) begin
                        state <= START_BIT;
                        start_bit_detected <= 1'b1;
                        stop_bit_detected <= 1'b0;
                    end
                end
                START_BIT: begin
                    state <= DATA_BITS;
                    data <= 1'b0;
                end
                DATA_BITS: begin
                    if (in == 1'b1) begin
                        data <= {data[6:0], in}; // Shift in received bit
                    end
                    if (data == 8'b111_11110) begin // Check if stop bit is expected value (1)
                        state <= STOP_BIT;
                        stop_bit_detected <= 1'b1;
                    end
                end
                STOP_BIT: begin
                    state <= IDLE;
                    done <= 1'b1;
                    start_bit_detected <= 1'b0;
                    stop_bit_detected <= 1'b0;
                end
            endcase
        end
    end

    // Output
    assign done = stop_bit_detected;

endmodule
