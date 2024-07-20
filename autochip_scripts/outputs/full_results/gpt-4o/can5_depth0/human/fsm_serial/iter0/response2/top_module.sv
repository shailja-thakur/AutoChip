module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);
    // State definition
    typedef enum logic [2:0] {
        IDLE = 3'b000,
        START_BIT = 3'b001,
        DATA_BITS = 3'b010,
        STOP_BIT = 3'b011,
        WAIT_FOR_IDLE = 3'b100
    } state_t;

    // State variables
    state_t current_state, next_state;
    reg [2:0] bit_count;
    reg [7:0] data_byte;

    // Sequential logic for state transitions
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            bit_count <= 3'b000;
            data_byte <= 8'b0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == DATA_BITS) begin
                if (bit_count < 3'b111) begin
                    bit_count <= bit_count + 3'b001;
                    data_byte <= {in, data_byte[7:1]};
                end else begin
                    bit_count <= 3'b000;
                end
            end
        end
    end

    // Combinational logic for next state and outputs
    always @(*) begin
        next_state = current_state;
        done = 1'b0;
        case (current_state)
            IDLE: begin
                if (in == 1'b0) begin
                    next_state = START_BIT;
                end
            end
            START_BIT: begin
                next_state = DATA_BITS;
            end
            DATA_BITS: begin
                if (bit_count == 3'b111) begin
                    next_state = STOP_BIT;
                end
            end
            STOP_BIT: begin
                if (in == 1'b1) begin
                    done = 1'b1;
                    next_state = IDLE;
                end else begin
                    next_state = WAIT_FOR_IDLE;
                end
            end
            WAIT_FOR_IDLE: begin
                if (in == 1'b1) begin
                    next_state = IDLE;
                end
            end
        endcase
    end

endmodule
