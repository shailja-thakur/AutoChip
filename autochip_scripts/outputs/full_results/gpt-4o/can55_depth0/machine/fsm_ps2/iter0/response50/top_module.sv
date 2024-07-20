module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    // State Encoding
    typedef enum reg [1:0] {
        BYTE1 = 2'b00,
        BYTE2 = 2'b01,
        BYTE3 = 2'b10,
        DONE  = 2'b11
    } state_t;

    state_t current_state, next_state;

    // State Transition Logic
    always @(*) begin
        case (current_state)
            BYTE1: if (in[3]) next_state = BYTE2;
                   else next_state = BYTE1;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = DONE;
            DONE:  if (in[3]) next_state = BYTE2;
                   else next_state = BYTE1;
            default: next_state = BYTE1;
        endcase
    end

    // State Flip-Flops with Asynchronous Reset
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= BYTE1;
        else
            current_state <= next_state;
    end

    // Output Logic
    always @(*) begin
        done = (current_state == DONE);
    end

endmodule
