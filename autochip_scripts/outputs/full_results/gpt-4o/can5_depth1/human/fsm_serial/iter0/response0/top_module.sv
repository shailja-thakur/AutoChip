module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);
    // State encoding
    typedef enum logic [2:0] {
        IDLE      = 3'b000,
        START     = 3'b001,
        DATA      = 3'b010,
        STOP      = 3'b011,
        ERROR     = 3'b100
    } state_t;
    
    state_t current_state, next_state;
    reg [2:0] bit_count;  // To count the 8 data bits
    
    // State transition block (sequential)
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            done <= 0;
            bit_count <= 0;
        end
        else begin
            current_state <= next_state;
            if (current_state == START) begin
                bit_count <= 0;
            end
            else if (current_state == DATA) begin
                bit_count <= bit_count + 1;
            end
        end
    end

    // Next state logic block (combinational)
    always_comb begin
        next_state = current_state;
        done = 0;
        case (current_state)
            IDLE: begin
                if (in == 0)  // Detect start bit
                    next_state = START;
            end

            START: begin
                next_state = DATA;
            end

            DATA: begin
                if (bit_count == 7)
                    next_state = STOP;
            end

            STOP: begin
                if (in == 1) begin  // Ensure stop bit is high
                    next_state = IDLE;
                    done = 1;
                end
                else
                    next_state = ERROR;
            end

            ERROR: begin
                if (in == 1)
                    next_state = IDLE;
            end
            
            default: next_state = IDLE;
        endcase
    end
endmodule
