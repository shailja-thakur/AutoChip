module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

    // Define the states of the FSM
    typedef enum reg [1:0] {
        IDLE = 2'b00,
        BYTE_1 = 2'b01,
        BYTE_2 = 2'b10,
        BYTE_3 = 2'b11
    } fsm_state_t;
    fsm_state_t state, next_state;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end
        else begin
            state <= next_state;
        end
    end
    
    always @(*) begin
        done = 0; // Default done to 0
        next_state = state;
        
        case (state)
            IDLE: begin
                if (in[3] == 1'b1) begin
                    next_state = BYTE_1;
                end
            end
            BYTE_1: begin
                next_state = BYTE_2;
            end
            BYTE_2: begin
                next_state = BYTE_3;
            end
            BYTE_3: begin
                done = 1'b1; // Signal done on the cycle after the third byte
                if (in[3] == 1'b1) begin
                    next_state = BYTE_1; // If next byte starts with in[3]=1, assume it's the next message
                end
                else begin
                    next_state = IDLE;
                end
            end
        endcase
    end

endmodule
