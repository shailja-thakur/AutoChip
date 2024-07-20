module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);
    // State definition
    typedef enum logic [2:0] {
        IDLE    = 3'b000,
        START   = 3'b001,
        DATA    = 3'b010,
        STOP    = 3'b011,
        ERROR   = 3'b100
    } state_t;

    state_t current_state, next_state;
    reg [2:0] bit_count;
    reg [7:0] data_reg;

    // State register
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            bit_count <= 3'b000;
            out_byte <= 8'b0;
            done <= 1'b0;
            data_reg <= 8'b0;
        end else begin
            current_state <= next_state;
            if (current_state == DATA && next_state == DATA) begin
                data_reg[bit_count] <= in; // Shift in the data bits
                bit_count <= bit_count + 1;
            end
            if (next_state == IDLE) bit_count <= 3'b0;
            if (current_state == STOP && next_state == IDLE) begin
                out_byte <= data_reg;
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
        end
    end

    // Next state logic
    always_comb begin
        next_state = current_state;
        case (current_state)
            IDLE: begin
                if (in == 1'b0) begin // Detect start bit
                    next_state = START;
                end
            end
            START: begin
                if (in == 1'b0) begin // Confirm start bit continues to be 0
                    next_state = DATA;
                end else begin
                    next_state = IDLE;
                end
            end
            DATA: begin
                if (bit_count == 3'b111) begin // Last data bit received
                    next_state = STOP;
                end
            end
            STOP: begin
                if (in == 1'b1) begin // Detect stop bit
                    next_state = IDLE;
                end else begin
                    next_state = ERROR;
                end
            end
            ERROR: begin
                if (in == 1'b1) begin // Wait for stop bit to return to idle
                    next_state = IDLE;
                end
            end
        endcase
    end
endmodule
