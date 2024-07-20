module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    // Define states
    typedef enum reg [1:0] {
        STATE_WAIT = 2'b00,
        STATE_BYTE1 = 2'b01,
        STATE_BYTE2 = 2'b10,
        STATE_BYTE3 = 2'b11
    } state_t;
    
    state_t state, next_state;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            STATE_WAIT: 
                if (in[3] == 1'b1)         next_state = STATE_BYTE1;
                else                       next_state = STATE_WAIT;
            STATE_BYTE1:                  next_state = STATE_BYTE2;
            STATE_BYTE2:                  next_state = STATE_BYTE3;
            STATE_BYTE3:                  next_state = STATE_WAIT;
            default:                      next_state = STATE_WAIT;
        endcase
    end

    // State register logic (sequential)
    always @(posedge clk) begin
        if (reset)
            state <= STATE_WAIT;
        else
            state <= next_state;
    end

    // Output logic
    always @(posedge clk) begin
        if (reset)
            done <= 0;
        else if (state == STATE_BYTE3)
            done <= 1;
        else
            done <= 0;
    end

endmodule
