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
        START = 3'b001,
        DATA = 3'b010,
        STOP = 3'b011,
        ERROR = 3'b100
    } state_t;
    
    state_t state, next_state;
    reg [2:0] bit_count;
    reg [7:0] shift_reg;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_count <= 3'b000;
            shift_reg <= 8'b00000000;
            done <= 1'b0;
            out_byte <= 8'b00000000;
        end else begin
            state <= next_state;
            if (next_state == DATA) begin
                shift_reg <= {in, shift_reg[7:1]};
                bit_count <= bit_count + 1;
            end else if (next_state == STOP && state == DATA) begin
                out_byte <= shift_reg;
                bit_count <= 3'b000;
            end else if (next_state == IDLE) begin
                bit_count <= 3'b000;
                shift_reg <= 8'b00000000;
            end
            done <= (next_state == STOP && in == 1'b1);
        end
    end

    always @(*) begin
        next_state = state;
        case (state)
            IDLE: begin
                if (in == 1'b0) // Detect start bit
                    next_state = START;
            end
            START: begin
                next_state = DATA;
            end
            DATA: begin
                if (bit_count == 3'd7)
                    next_state = STOP;
            end
            STOP: begin
                if (in == 1'b1) // Verify stop bit
                    next_state = IDLE;
                else
                    next_state = ERROR;
            end
            ERROR: begin
                if (in == 1'b1) // Wait for a stop bit to return to IDLE
                    next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

endmodule
