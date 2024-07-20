module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    // State encoding
    typedef enum logic [2:0] {
        IDLE = 3'b000,
        START_BIT = 3'b001,
        DATA_BITS = 3'b010,
        STOP_BIT = 3'b011,
        ERROR = 3'b100
    } state_t;

    state_t state, next_state;
    reg [7:0] data_shift;
    reg [2:0] bit_counter;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            data_shift <= 8'd0;
            bit_counter <= 3'd0;
            done <= 1'b0;
            out_byte <= 8'd0;
        end else begin
            state <= next_state;
            if (state == START_BIT) begin
                bit_counter <= 3'd0;
            end else if (state == DATA_BITS) begin
                data_shift <= {in, data_shift[7:1]};
                bit_counter <= bit_counter + 1;
            end

            if (state == STOP_BIT) begin
                if (in == 1'b1) begin // valid stop bit
                    done <= 1'b1;
                    out_byte <= data_shift;
                end else begin // error, stop bit is not high
                    done <= 1'b0;
                end
            end else begin
                done <= 1'b0;
            end
        end
    end

    always_comb begin
        next_state = state;
        case (state)
            IDLE: if (in == 1'b0) next_state = START_BIT; // detect start bit
            START_BIT: next_state = DATA_BITS;
            DATA_BITS: if (bit_counter == 3'd7) next_state = STOP_BIT;
            STOP_BIT: if (in == 1'b1) next_state = IDLE; // wait for idle
                      else next_state = ERROR; // stop bit error
            ERROR: if (in == 1'b1) next_state = IDLE; // wait for proper idle state
            default: next_state = IDLE;
        endcase
    end

endmodule
