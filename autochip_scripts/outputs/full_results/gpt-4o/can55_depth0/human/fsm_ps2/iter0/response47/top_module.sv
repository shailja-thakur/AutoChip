module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);
    
    // State encoding
    typedef enum reg [1:0] {
        IDLE = 2'b00,
        BYTE1 = 2'b01,
        BYTE2 = 2'b10,
        BYTE3 = 2'b11
    } state_t;
    
    reg [1:0] state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            IDLE:   next_state = (in[3] == 1'b1) ? BYTE1 : IDLE;
            BYTE1:  next_state = BYTE2;
            BYTE2:  next_state = BYTE3;
            BYTE3:  next_state = (in[3] == 1'b1) ? BYTE1 : IDLE;
            default: next_state = IDLE;
        endcase
    end
    
    // State register
    always @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Output logic
    always @(posedge clk) begin
        if (reset)
            done <= 1'b0;
        else if (state == BYTE3)
            done <= 1'b1;
        else
            done <= 1'b0;
    end

endmodule
