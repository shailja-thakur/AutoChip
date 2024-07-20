module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    typedef enum reg [2:0] {
        IDLE      = 3'b000,
        START_BIT = 3'b001,
        DATA_BITS = 3'b010,
        STOP_BIT  = 3'b011,
        ERROR     = 3'b100
    } state_t;

    state_t current_state, next_state;
    reg [2:0] bit_count;
    reg [7:0] data_reg;
    reg done_next;

    // Sequential Logic: State transitions and outputs
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            bit_count <= 0;
            out_byte <= 8'b0;
            done <= 0;
            data_reg <= 8'b0;
        end else begin
            current_state <= next_state;
            done <= done_next;

            if (next_state == DATA_BITS && current_state != DATA_BITS) begin
                bit_count <= 0;
            end else if (next_state == DATA_BITS) begin
                data_reg[bit_count] <= in;
                bit_count <= bit_count + 1;
            end

            if (current_state == STOP_BIT && next_state == IDLE) begin
                out_byte <= data_reg;
            end
        end
    end

    // Combinational logic: Next state and done logic
    always @(*) begin
        next_state = current_state;
        done_next = 0;

        case (current_state)
            IDLE: begin
                if (in == 0) begin // Start bit detected
                    next_state = START_BIT;
                end
            end

            START_BIT: begin
                next_state = DATA_BITS;
            end

            DATA_BITS: begin
                if (bit_count == 3'd7) begin // All 8 data bits received
                    next_state = STOP_BIT;
                end
            end

            STOP_BIT: begin
                if (in == 1) begin // Valid stop bit
                    done_next = 1;
                    next_state = IDLE;
                end else begin // Invalid stop bit, goes to ERROR
                    next_state = ERROR;
                end
            end

            ERROR: begin
                done_next = 0;
                if (in == 1) begin // Wait for line to return to idle state
                    next_state = IDLE;
                end
            end

            default: next_state = IDLE;
        endcase
    end

endmodule
