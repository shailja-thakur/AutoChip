module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        BYTE1 = 2'b01,
        BYTE2 = 2'b10,
        BYTE3 = 2'b11
    } state_t;

    state_t state, next_state;
    
    // State transition logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end
    
    // Next state logic
    always_comb begin
        done = 1'b0;
        case (state)
            IDLE: begin
                if (in[3]) begin
                    next_state = BYTE1;
                end else begin
                    next_state = IDLE;
                end
            end
            BYTE1: next_state = BYTE2;
            BYTE2: next_state = BYTE3;
            BYTE3: begin
                done = 1'b1;
                if (in[3]) begin
                    next_state = BYTE1;
                end else begin
                    next_state = IDLE;
                end
            end
            default: next_state = IDLE;
        endcase
    end
    
endmodule
