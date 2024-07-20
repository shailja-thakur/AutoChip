module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    // State encoding
    typedef enum reg [2:0] {
        IDLE      = 3'b000,
        START_BIT = 3'b001,
        DATA_BITS = 3'b010,
        STOP_BIT  = 3'b011
    } state_t;
    
    state_t current_state, next_state;
    reg [2:0] bit_count;
    
    // Sequential Logic: State transitions and data shifting
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            bit_count <= 3'b000;
            out_byte <= 8'b0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            done <= 1'b0;

            if (current_state == DATA_BITS && next_state == DATA_BITS) begin
                out_byte[bit_count] <= in;
                bit_count <= bit_count + 1;
            end else if (next_state == STOP_BIT) begin
                out_byte[bit_count] <= in;
            end

            if (next_state == IDLE || next_state == STOP_BIT) begin
                bit_count <= 3'b000;
            end

            if (next_state == STOP_BIT && current_state == DATA_BITS) begin
                done <= 1'b1;
            end
        end
    end

    // Combinational Logic: Next state logic
    always @(*) begin
        next_state = current_state;
        
        case (current_state)
            IDLE: begin
                if (in == 1'b0) // Start bit detected
                    next_state = START_BIT;
            end

            START_BIT: begin
                next_state = DATA_BITS;
            end

            DATA_BITS: begin
                if (bit_count == 3'd7) // All 8 data bits received
                    next_state = STOP_BIT;
                else
                    next_state = DATA_BITS;
            end

            STOP_BIT: begin
                if (in == 1'b1) // Valid stop bit
                    next_state = IDLE;
                else // Invalid stop bit, re-sync
                    next_state = IDLE;
            end

        endcase
    end

endmodule
