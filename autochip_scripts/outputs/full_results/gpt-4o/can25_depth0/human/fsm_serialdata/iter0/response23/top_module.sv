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
        CHECK_STOP_BIT = 3'b100
    } state_t;
    
    state_t current_state, next_state;
    reg [2:0] bit_count;
    reg [7:0] data_register;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            bit_count <= 3'b0;
            data_register <= 8'b0;
            out_byte <= 8'b0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == DATA_BITS) begin
                data_register[bit_count] <= in;
            end
            if (current_state == STOP_BIT) begin
                out_byte <= data_register;
            end
            if (current_state == CHECK_STOP_BIT && in == 1'b1) begin
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
            if (current_state == IDLE) begin
                bit_count <= 3'b0;
            end else if (current_state == DATA_BITS) begin
                bit_count <= bit_count + 1'b1;
            end
        end
    end

    always_comb begin
        case (current_state)
            IDLE: begin
                if (in == 1'b0) // Detect start bit
                    next_state = START_BIT;
                else
                    next_state = IDLE;
            end
            START_BIT: begin
                next_state = DATA_BITS;
            end
            DATA_BITS: begin
                if (bit_count == 3'b111) // 8 data bits received
                    next_state = STOP_BIT;
                else
                    next_state = DATA_BITS;
            end
            STOP_BIT: begin
                next_state = CHECK_STOP_BIT;
            end
            CHECK_STOP_BIT: begin
                if (in == 1'b1) // Valid stop bit
                    next_state = IDLE;
                else
                    next_state = CHECK_STOP_BIT;
            end
            default: next_state = IDLE;
        endcase
    end

endmodule
