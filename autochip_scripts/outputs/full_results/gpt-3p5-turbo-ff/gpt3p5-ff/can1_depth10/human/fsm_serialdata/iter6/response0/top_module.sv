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
            data_byte <= in ? {data_byte[6:0], in} : data_byte;
            start_detected <= next_state == START_BIT ? 1'b1 : 1'b0;
            stop_detected <= next_state == STOP_BIT ? 1'b1 : 1'b0;
            bit_counter <= next_state == DATA_BITS ? bit_counter + 1'b1 : 3'b0;
            
            if (in == 1'b1) begin
                sample_counter <= sample_counter + 1'b1;
            end
        end
    end

    // Next state logic
    always_comb begin
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

    // Output logic
    always_ff @(posedge clk) begin
        if (reset) begin
            done <= 1'b0;
            out_byte <= 8'b0;
        end else begin
            case (current_state)
                IDLE, START_BIT, DATA_BITS:
                    done <= 1'b0;
                STOP_BIT:
                    done <= 1'b1;
            endcase
            
            if (done) begin
                out_byte <= data_byte;
            end
        end
    end

endmodule
