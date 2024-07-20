module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    // State encoding
    typedef enum logic [1:0] {
        IDLE = 2'b00,     // Waiting for the first byte with in[3]=1
        BYTE1 = 2'b01,    // First byte of message received
        BYTE2 = 2'b10,    // Second byte of message received
        BYTE3 = 2'b11     // Third byte of message received
    } state_t;

    state_t current_state, next_state;

    // State transition
    always_ff @(posedge clk) begin
        if (reset)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    // Next state logic
    always_comb begin
        done = 1'b0;
        next_state = current_state;
        
        case (current_state)
            IDLE: begin
                if (in[3] == 1'b1) 
                    next_state = BYTE1;
                else
                    next_state = IDLE;
            end
            
            BYTE1: 
                next_state = BYTE2;
                
            BYTE2: 
                next_state = BYTE3;
                
            BYTE3: begin
                done = 1'b1;
                if (in[3] == 1'b1) 
                    next_state = BYTE1;
                else
                    next_state = IDLE;
            end
        endcase
    end

endmodule
