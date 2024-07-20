module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);
    // State encoding
    typedef enum logic [2:0] {
        IDLE       = 3'b000,
        START_BIT  = 3'b001,
        DATA_BITS  = 3'b010,
        STOP_BIT   = 3'b011,
        CHECK_STOP = 3'b100
    } state_t;

    state_t current_state, next_state;
    reg [2:0] bit_count;

    // State transition logic
    always_ff @(posedge clk or posedge reset) begin
        if(reset) begin
            current_state <= IDLE;
            bit_count <= 3'b000;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == DATA_BITS)
                bit_count <= bit_count + 3'b001;
            else
                bit_count <= 3'b000;
            
            if (current_state == STOP_BIT && in == 1'b1) 
                done <= 1'b1;
            else 
                done <= 1'b0;
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            IDLE: begin
                if (in == 1'b0)
                    next_state = START_BIT;
                else
                    next_state = IDLE;
            end
            START_BIT: begin
                next_state = DATA_BITS;
            end
            DATA_BITS: begin
                if (bit_count == 3'b111)
                    next_state = STOP_BIT;
                else
                    next_state = DATA_BITS;
            end
            STOP_BIT: begin
                if (in == 1'b1)
                    next_state = IDLE;
                else
                    next_state = CHECK_STOP;
            end
            CHECK_STOP: begin
                if (in == 1'b1)
                    next_state = IDLE;
                else
                    next_state = CHECK_STOP;
            end
            default: next_state = IDLE;
        endcase
    end
endmodule
