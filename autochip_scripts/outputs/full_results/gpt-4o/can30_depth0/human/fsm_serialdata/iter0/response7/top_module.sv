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

    state_t current_state, next_state;
    reg [2:0] bit_cnt; // to count the 8 data bits
    reg [7:0] data_reg; // to store the received byte

    // State transition logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            bit_cnt <= 0;
            out_byte <= 8'b0;
            data_reg <= 8'b0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state != DATA_BITS) bit_cnt <= 0;
            else bit_cnt <= bit_cnt + 1;

            if (current_state == DATA_BITS) data_reg[bit_cnt] <= in;
            if (current_state == STOP_BIT) out_byte <= data_reg;
        end
    end

    // Next state logic
    always_comb begin
        next_state = current_state;
        done = 1'b0;

        case (current_state)
            IDLE: begin
                if (in == 1'b0) // start bit detected
                    next_state = START_BIT;
            end
            START_BIT: begin
                next_state = DATA_BITS;
            end
            DATA_BITS: begin
                if (bit_cnt == 3'd7) // received all 8 data bits
                    next_state = STOP_BIT;
            end
            STOP_BIT: begin
                if (in == 1'b1) begin // stop bit detected
                    done = 1'b1;
                    next_state = IDLE;
                end else begin // invalid frame, wait for stop bit
                    next_state = IDLE; // Change this to NOT "IDLE" if you want to wait in STOP_BIT state
                end
            end
            default: next_state = IDLE;
        endcase
    end

endmodule
