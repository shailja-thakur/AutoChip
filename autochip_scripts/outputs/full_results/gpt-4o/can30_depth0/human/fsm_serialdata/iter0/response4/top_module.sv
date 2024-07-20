module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);
    // State encoding
    typedef enum reg [2:0] {
        IDLE = 3'b000,
        START_BIT = 3'b001,
        DATA_BITS = 3'b010,
        STOP_BIT = 3'b011,
        ERROR = 3'b100
    } state_t;

    state_t state, next_state;
    reg [2:0] bit_count;
    reg [7:0] data_reg;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            done <= 0;
            bit_count <= 0;
            out_byte <= 8'h00;
            data_reg <= 8'h00;
        end
        else begin
            state <= next_state;
            if (next_state == DATA_BITS) begin
                data_reg[bit_count] <= in;
                
            end
            else if (next_state == STOP_BIT) begin
                out_byte <= data_reg;
                done <= 1;  // Signal that we have a valid data byte
            end
            else if (next_state == IDLE) begin
                done <= 0; // Clear the done flag
            end
        end
    end

    always @(*) begin
        case (state)
            IDLE: begin
                if (in == 0) begin
                    next_state = START_BIT;
                end
                else begin
                    next_state = IDLE;
                end
            end
            START_BIT: begin
                next_state = DATA_BITS;
                bit_count = 0;
            end
            DATA_BITS: begin
                if (bit_count < 7) begin
                    next_state = DATA_BITS;
                    bit_count = bit_count + 1;
                end
                else begin
                    next_state = STOP_BIT;
                end
            end
            STOP_BIT: begin
                if (in == 1) begin
                    next_state = IDLE;
                end
                else begin
                    next_state = ERROR;  // Error if stop bit is not 1
                end
            end
            ERROR: begin
                if (in == 1) begin
                    next_state = IDLE;
                end
                else begin
                    next_state = ERROR;
                end
            end
            default: next_state = IDLE;
        endcase
    end
endmodule
