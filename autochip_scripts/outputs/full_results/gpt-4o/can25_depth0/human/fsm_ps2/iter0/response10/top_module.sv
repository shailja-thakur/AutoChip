module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    // State encoding
    typedef enum reg [1:0] {
        IDLE  = 2'b00, // Waiting for the first byte with in[3] = 1
        BYTE1 = 2'b01, // Received first byte
        BYTE2 = 2'b10, // Received second byte
        BYTE3 = 2'b11  // Received third byte
    } state_t;

    state_t state, next_state;

    // State transition
    always @(posedge clk) begin
        if (reset) 
            state <= IDLE;
        else 
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (in[3] == 1)
                    next_state = BYTE1;
                else
                    next_state = IDLE;
            end
            
            BYTE1: begin
                next_state = BYTE2;
            end

            BYTE2: begin
                next_state = BYTE3;
            end

            BYTE3: begin
                next_state = IDLE;
            end
            
            default: next_state = IDLE;
        endcase
    end

    // Output logic
    always @(posedge clk) begin
        if (reset)
            done <= 0;
        else if (state == BYTE3)
            done <= 1;
        else
            done <= 0;
    end

endmodule
