module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    // State encoding
    typedef enum reg [1:0] {
        WAIT_FOR_FIRST_BYTE = 2'b00,
        BYTE_2              = 2'b01,
        BYTE_3              = 2'b10
    } state_t;
    
    state_t state, next_state;

    // Synchronous reset and state transition logic
    always @(posedge clk) begin
        if (reset)
            state <= WAIT_FOR_FIRST_BYTE;
        else
            state <= next_state;
    end

    // Next state logic and output generation
    always @(*) begin
        // Default outputs
        done = 1'b0;
        next_state = state;
        
        case (state)
            WAIT_FOR_FIRST_BYTE: begin
                if (in[3] == 1'b1)
                    next_state = BYTE_2;
            end
            
            BYTE_2: begin
                next_state = BYTE_3;
            end
            
            BYTE_3: begin
                next_state = WAIT_FOR_FIRST_BYTE;
                done = 1'b1;
            end
            
            default: begin
                next_state = WAIT_FOR_FIRST_BYTE;
            end
        endcase
    end

endmodule
