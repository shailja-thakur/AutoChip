module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    // State encoding
    typedef enum logic [2:0] {
        IDLE     = 3'b000,
        START    = 3'b001,
        RECEIVE  = 3'b010,
        STOP     = 3'b011,
        WAIT_STOP = 3'b100
    } state_t;
    state_t current_state, next_state;

    reg [7:0] data_shift;
    reg [2:0] bit_count;
    
    // Synchronous state transition
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end
    
    // Next state logic
    always @(*) begin
        next_state = current_state; // Default to stay in current state
        case (current_state)
            IDLE: begin
                if (in == 1'b0)
                    next_state = START;
            end
            START: begin
                next_state = RECEIVE;
            end
            RECEIVE: begin
                if (bit_count == 3'd7)
                    next_state = STOP;
            end
            STOP: begin
                if (in == 1'b1)
                    next_state = IDLE;
                else
                    next_state = WAIT_STOP;
            end
            WAIT_STOP: begin
                if (in == 1'b1)
                    next_state = IDLE;
            end
        endcase
    end
    
    // Synchronous outputs and data shifting
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            done <= 1'b0;
            bit_count <= 3'b0;
            data_shift <= 8'b0;
        end else begin
            done <= 1'b0; // Default to 0, will be set to 1 in STOP state
            case (current_state)
                IDLE: begin
                    bit_count <= 3'b0;
                    data_shift <= 8'b0;
                end
                START: begin
                    // No action required
                end
                RECEIVE: begin
                    /* Shift in the incoming bits, LSB first */
                    data_shift <= {in, data_shift[7:1]};
                    bit_count <= bit_count + 3'd1;
                end
                STOP: begin
                    if (in == 1'b1) begin // Verify Stop bit
                        out_byte <= data_shift;
                        done <= 1'b1;
                    end
                    bit_count <= 3'b0; // Reset counter for next byte
                end
                WAIT_STOP: begin
                    // No action required
                end
            endcase
        end
    end
endmodule
