module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    // Define states
    typedef enum logic [2:0] {
        IDLE,
        START_BIT,
        DATA_BITS,
        STOP_BIT
    } state_t;
    
    // Define signals
    state_t current_state, next_state;
    reg [7:0] data_byte;
    reg start_detected, stop_detected;
    reg [2:0] bit_counter;
    reg [1:0] sample_counter;
    
    // Synchronous reset
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            data_byte <= 8'b0;
            start_detected <= 1'b0;
            stop_detected <= 1'b0;
            bit_counter <= 3'b0;
            sample_counter <= 2'b0;
            out_byte <= 8'b0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            case (current_state)
                IDLE:
                    if (in == 1'b0) begin
                        next_state = START_BIT;
                    end else begin
                        next_state = IDLE;
                    end
                START_BIT:
                    if (bit_counter == 3'b0) begin
                        next_state = DATA_BITS;
                    end else begin
                        next_state = START_BIT;
                    end
                DATA_BITS:
                    if (bit_counter == 3'b111) begin
                        next_state = STOP_BIT;
                    end else begin
                        next_state = DATA_BITS;
                    end
                STOP_BIT:
                    if (stop_detected) begin
                        next_state = IDLE;
                    end else begin
                        next_state = STOP_BIT;
                    end
                default:
                    next_state = IDLE;
            endcase
        end
    end

    // Output and next state logic
    always_ff @(posedge clk) begin
        start_detected <= 0;
        stop_detected <= 0;
        sample_counter <= sample_counter + 1;
        
        case (current_state)
            IDLE:
                if (in == 1'b0) begin
                    start_detected <= 1'b1;
                end
            START_BIT:
                if (bit_counter == 3'b0) begin
                    start_detected <= 1'b0;
                end
                if (bit_counter == 3'b1 && in == 1'b1) begin
                    stop_detected <= 1'b1;
                end
            DATA_BITS:
                if (bit_counter == 3'b0) begin
                    start_detected <= 1'b0;
                    stop_detected <= 1'b0;
                end
                if (bit_counter == 3'b1 && in == 1'b1) begin
                    stop_detected <= 1'b1;
                end
            STOP_BIT:
                if (sample_counter == 2'b11) begin
                    done <= 1'b1;
                end else begin
                    done <= 1'b0;
                end
        endcase
        
        if (done) begin
            out_byte <= data_byte;
        end else begin
            out_byte <= 8'b0;
        end
    end

endmodule
