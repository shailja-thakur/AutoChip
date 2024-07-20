module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);
    // State declaration
    typedef enum reg [1:0] {
        BYTE1 = 2'b00,
        BYTE2 = 2'b01,
        BYTE3 = 2'b10,
        DONE = 2'b11
    } state_t;

    // State register
    state_t state, next_state;

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) 
            state <= BYTE1;
        else
            state <= next_state;
    end

    // Next state logic and output logic
    always @(state or in) begin
        // Default assignments
        done = 1'b0;
        next_state = state;

        case (state)
            BYTE1: begin
                if (in[2] == 1'b1)
                    next_state = BYTE2;
            end
            BYTE2: begin
                next_state = BYTE3;
            end
            BYTE3: begin
                next_state = DONE;
            end
            DONE: begin
                done = 1'b1;
                if (in[2] == 1'b0)
                    next_state = BYTE1;
                else
                    next_state = BYTE2;
            end
            default: begin
                next_state = BYTE1;
            end
        endcase
    end

endmodule
