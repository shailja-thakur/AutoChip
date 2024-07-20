module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    // State declaration
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
            IDLE: begin
                if (in[3] == 1)
                    next_state = BYTE1;
                else
                    next_state = IDLE;
            end
            BYTE1: next_state = BYTE2;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

    // State flip-flops and done signal logic
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            done <= 0;
        end else begin
            state <= next_state;
            // Set done signal when transitioning from BYTE3 to IDLE
            done <= (state == BYTE3);
        end
    end

endmodule
