module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);
    // State definitions
    typedef enum reg [1:0] {
        WAITING = 2'b00, // waiting for the start of a message
        BYTE_1 = 2'b01,  // first byte of the message
        BYTE_2 = 2'b10,  // second byte of the message
        BYTE_3 = 2'b11   // third byte of the message
    } state_t;
    
    state_t state, next_state;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= WAITING;
        end else begin
            state <= next_state;
        end
    end
    
    always @(*) begin
        done = 1'b0; // Default done signal is 0
        case (state)
            WAITING: begin
                if (in[3] == 1'b1) begin
                    next_state = BYTE_1;
                end else begin
                    next_state = WAITING;
                end
            end
            
            BYTE_1: begin
                next_state = BYTE_2;
            end
            
            BYTE_2: begin
                next_state = BYTE_3;
            end
            
            BYTE_3: begin
                next_state = WAITING;
                done = 1'b1; // Signal done after the third byte
            end
            
            default: begin
                next_state = WAITING;
            end
        endcase
    end
endmodule
