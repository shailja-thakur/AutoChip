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
    
    state_t state, next_state;

    // State transition
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic and output logic
    always @(*) begin
        // Default values for next state and output
        next_state = state;
        done = 1'b0;

        case (state)
            IDLE: begin
                if (in[3] == 1'b1) begin
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
                done = 1'b1;
                if (in[3] == 1'b1) begin
                    next_state = BYTE1;  // Ready for a new message
                end else begin
                    next_state = IDLE;
                end
            end
        endcase
    end

endmodule
