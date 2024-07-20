module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    // State enumeration
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        BYTE1 = 2'b01,
        BYTE2 = 2'b10,
        BYTE3 = 2'b11
    } state_t;
    
    state_t state, next_state;

    // State transition
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        next_state = state;
        done = 1'b0;
        
        case (state)
            IDLE: begin
                if (in[3] == 1'b1) begin
                    next_state = BYTE1;
                end
            end
            
            BYTE1: begin
                next_state = BYTE2;
            end
            
            BYTE2: begin
                next_state = BYTE3;
            end
            
            BYTE3: begin
                next_state = IDLE;  // Transition back to IDLE after receiving the third byte
                done = 1'b1;  // Signal done for 1 cycle
            end
            
            default: begin
                next_state = IDLE;  // Default state
            end
        endcase
    end

endmodule
