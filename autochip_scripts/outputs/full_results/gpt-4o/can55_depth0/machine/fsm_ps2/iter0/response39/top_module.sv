module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    // State encoding
    typedef enum reg [1:0] {
        BYTE1 = 2'b00,
        BYTE2 = 2'b01,
        BYTE3 = 2'b10,
        DONE  = 2'b11
    } state_t;
    
    // State variables
    reg [1:0] state, next_state;
    
    // State transition logic
    always @(*) begin
        case (state)
            BYTE1: 
                if (in[2])
                    next_state = BYTE2;
                else
                    next_state = BYTE1;
            BYTE2: 
                next_state = BYTE3;
            BYTE3: 
                next_state = DONE;
            DONE: 
                if (in[2])
                    next_state = BYTE2;
                else
                    next_state = BYTE1;
            default: 
                next_state = BYTE1;
        endcase
    end

    // State register
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= BYTE1;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        done = (state == DONE);
    end

endmodule
