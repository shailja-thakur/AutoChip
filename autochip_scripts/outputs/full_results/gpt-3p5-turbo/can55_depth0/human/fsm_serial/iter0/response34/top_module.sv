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

    // Define state registers
    logic [2:0] current_state;
    logic [2:0] next_state;

    // Define start bit detection and verification registers
    logic start_bit_detected;
    logic start_bit_verified;

    // Define data bit count register
    logic [2:0] data_bit_count;

    // Define stop bit detection register
    logic stop_bit_detected;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            next_state <= IDLE;
            start_bit_detected <= 0;
            start_bit_verified <= 0;
            data_bit_count <= 0;
            stop_bit_detected <= 0;
            done <= 0;
        end else begin
            current_state <= next_state;
            start_bit_detected <= 0;
            start_bit_verified <= 0;
            data_bit_count <= 0;
            stop_bit_detected <= 0;
            done <= 0;
            case (current_state)
                IDLE:
                    if (in == 1'b0) begin
                        next_state <= START_BIT;
                    end else begin
                        next_state <= IDLE;
                    end
                START_BIT:
                    if (in == 1'b0) begin
                        start_bit_detected <= 1;
                        next_state <= DATA_BITS;
                    end else begin
                        next_state <= IDLE;
                    end
                DATA_BITS:
                    if (data_bit_count == 8) begin
                        next_state <= STOP_BIT;
                    end else begin
                        next_state <= DATA_BITS;
                    end
                STOP_BIT:
                    if (in == 1'b1) begin
                        stop_bit_detected <= 1;
                    end else begin
                        stop_bit_detected <= 0;
                    end
                    if (stop_bit_detected && start_bit_detected) begin
                        if (start_bit_verified) begin
                            done <= 1;
                            next_state <= IDLE;
                        end else begin
                            start_bit_verified <= 1;
                            next_state <= IDLE;
                        end
                    end else begin
                        next_state <= STOP_BIT;
                    end
                default:
                    next_state <= IDLE;
            endcase
            if (current_state == DATA_BITS && in == 1'b0) begin
                data_bit_count <= data_bit_count + 1;
            end
        end
    end
endmodule
