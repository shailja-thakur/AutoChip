module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    typedef enum reg [1:0] {
        IDLE       = 2'b00,
        BYTE1      = 2'b01,
        BYTE2      = 2'b10,
        BYTE3      = 2'b11
    } state_t;
    
    state_t current_state, next_state;

    always @(posedge clk) begin
        if (reset)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    always @(*) begin
        done = 0;
        next_state = current_state;
        
        case (current_state)
            IDLE: begin
                if (in[3] == 1) begin
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
                done = 1;  // Signal done in the cycle after the third byte
                if (in[3] == 1) begin
                    next_state = BYTE1;
                end else begin
                    next_state = IDLE;
                end
            end
        endcase
    end
endmodule
