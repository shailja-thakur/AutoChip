module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);
    typedef enum logic [1:0] {
        WAITING = 2'b00,
        BYTE1 = 2'b01,
        BYTE2 = 2'b10,
        DONE = 2'b11
    } state_t;

    state_t state, next_state;
    
    // State transition logic
    always @(*) begin
        case (state)
            WAITING: next_state = (in[3] == 1'b1) ? BYTE1 : WAITING;
            BYTE1: next_state = BYTE2;
            BYTE2: next_state = DONE;
            DONE: next_state = (in[3] == 1'b1) ? BYTE1 : WAITING;
            default: next_state = WAITING;
        endcase
    end
    
    // State register
    always @(posedge clk) begin
        if (reset)
            state <= WAITING;
        else
            state <= next_state;
    end
    
    // Output logic
    always @(posedge clk) begin
        if (reset)
            done <= 1'b0;
        else if (state == DONE)
            done <= 1'b1;
        else
            done <= 1'b0;
    end
endmodule
