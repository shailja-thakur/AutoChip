module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    typedef enum logic [2:0] {
        IDLE = 3'b000,
        START_BIT = 3'b001,
        DATA_BITS = 3'b010,
        STOP_BIT = 3'b011,
        ERROR = 3'b100
    } state_t;
    
    state_t state, next_state;
    reg [2:0] bit_count;
    reg [7:0] shift_reg;
    
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_count <= 0;
            shift_reg <= 0;
            out_byte <= 0;
            done <= 0;
        end else begin
            state <= next_state;
            if (next_state == START_BIT)
                bit_count <= 0;
            else if (next_state == DATA_BITS)
                bit_count <= bit_count + 1;
            if (state == DATA_BITS)
                shift_reg <= {in, shift_reg[7:1]};
            if (next_state == STOP_BIT)
                out_byte <= shift_reg;
        end
    end

    always_comb begin
        next_state = state;
        done = 0;
        case (state)
            IDLE: begin
                if (!in)
                    next_state = START_BIT;
            end
            START_BIT: begin
                if (in)
                    next_state = IDLE;  // False start, return to IDLE
                else
                    next_state = DATA_BITS;
            end
            DATA_BITS: begin
                if (bit_count == 7)
                    next_state = STOP_BIT;
            end
            STOP_BIT: begin
                if (in) begin
                    done = 1;
                    next_state = IDLE;
                end else
                    next_state = ERROR;
            end
            ERROR: begin
                if (in)
                    next_state = IDLE;  // Wait until the line is idle
            end
        endcase
    end
endmodule
