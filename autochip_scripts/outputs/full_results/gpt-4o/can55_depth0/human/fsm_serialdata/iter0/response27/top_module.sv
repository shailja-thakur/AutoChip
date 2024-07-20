module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    // State declaration
    typedef enum logic [2:0] {
        IDLE = 3'b000,
        START_BIT = 3'b001,
        DATA_BITS = 3'b010,
        STOP_BIT = 3'b011,
        DONE = 3'b100
    } state_t;

    state_t state, next_state;
    reg [2:0] bit_count;
    reg [7:0] temp_byte;

    // State transition on clock edge
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            done <= 1'b0;
            bit_count <= 3'b000;
            temp_byte <= 8'b00000000;
        end else begin
            state <= next_state;
            if (next_state == IDLE) begin
                done <= 1'b0;
            end
        end
    end

    // Next state logic
    always @(*) begin
        next_state = state;
        case (state)
            IDLE: begin
                if (~in) // start bit detected (logic 0)
                    next_state = START_BIT;
            end
            START_BIT: begin
                next_state = DATA_BITS;
            end
            DATA_BITS: begin
                if (bit_count == 3'b111) // All 8 bits received
                    next_state = STOP_BIT;
            end
            STOP_BIT: begin
                if (in) // stop bit (logic 1) detected
                    next_state = DONE;
                else
                    next_state = IDLE; // wait for the correct stop bit
            end
            DONE: begin
                next_state = IDLE;
            end
        endcase
    end

    // Output and bit counting logic
    always @(posedge clk) begin
        if (reset) begin
            out_byte <= 8'b00000000;
        end else begin
            case (state)
                START_BIT: begin
                    bit_count <= 3'b000;
                end
                DATA_BITS: begin
                    temp_byte[bit_count] <= in; // LSB first
                    bit_count <= bit_count + 1;
                end
                STOP_BIT: begin
                    // do nothing
                end
                DONE: begin
                    out_byte <= temp_byte;
                    done <= 1'b1;
                end
            endcase
        end
    end

endmodule
