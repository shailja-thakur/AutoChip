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
        STOP_BIT  = 3'b011
    } state_t;

    state_t current_state, next_state;
    reg [2:0] bit_count;
    reg [7:0] data_reg;

    // Sequential Logic: State transitions
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            bit_count <= 3'b0;
            out_byte <= 8'b0;
            done <= 0;
            data_reg <= 8'b0;
        end else begin
            current_state <= next_state;

            if (current_state == DATA_BITS) begin
                data_reg[bit_count] <= in;
                bit_count <= bit_count + 1;
            end

            if (current_state == STOP_BIT && in == 1) begin
                out_byte <= data_reg;
                done <= 1;
            end else begin
                done <= 0;
            end
        end
    end

    // Combinational Logic: Next state and output logic
    always @(*) begin
        next_state = current_state;

        case (current_state)
            IDLE: begin
                if (in == 0) begin  // Start bit detected
                    next_state = START_BIT;
                end
            end

            START_BIT: begin
                next_state = DATA_BITS;
            end

            DATA_BITS: begin
                if (bit_count == 3'b111) begin  // All 8 data bits received
                    next_state = STOP_BIT;
                end
            end

            STOP_BIT: begin
                if (in == 1) begin  // Valid stop bit
                    next_state = IDLE;
                end else begin  // Invalid stop bit, return to IDLE immediately
                    next_state = IDLE;
                end
            end

            default: next_state = IDLE;
        endcase
    end

endmodule
