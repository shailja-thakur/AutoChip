module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    // State definitions
    typedef enum logic [1:0] {
        BYTE1 = 2'b00,
        BYTE2 = 2'b01,
        BYTE3 = 2'b10,
        DONE  = 2'b11
    } state_t;
    
    state_t current_state, next_state;

    // Sequential logic for state transition
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= BYTE1;
        else
            current_state <= next_state;
    end

    // Combinational logic for next state
    always @(*) begin
        case (current_state)
            BYTE1: next_state = (in[2]) ? BYTE2 : BYTE1;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = DONE;
            DONE : next_state = (in[2]) ? BYTE2 : BYTE1;
            default: next_state = BYTE1;
        endcase
    end

    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            done <= 0;
        else
            done <= (current_state == DONE);
    end

endmodule
