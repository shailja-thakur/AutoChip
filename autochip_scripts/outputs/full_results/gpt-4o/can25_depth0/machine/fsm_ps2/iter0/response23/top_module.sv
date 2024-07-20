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

    // State registers
    state_t state, next_state;

    // Sequential logic for state transition
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= BYTE1;
        else
            state <= next_state;
    end

    // Combinational logic for next state and output logic
    always @(*) begin
        done = 0;
        case (state)
            BYTE1: begin
                if (in[2] == 1)
                    next_state = BYTE2;
                else
                    next_state = BYTE1;
            end
            BYTE2: begin
                next_state = BYTE3;
            end
            BYTE3: begin
                next_state = DONE;
            end
            DONE: begin
                done = 1;
                if (in[2] == 0)
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
