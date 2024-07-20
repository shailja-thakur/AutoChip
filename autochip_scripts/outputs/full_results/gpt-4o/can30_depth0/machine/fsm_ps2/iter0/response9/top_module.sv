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

    state_t current_state, next_state;

    // Sequential logic: State transition on clock edge
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= BYTE1;
        end else begin
            current_state <= next_state;
        end
    end

    // Combinatorial logic: Next state logic
    always @(*) begin
        case (current_state)
            BYTE1: if (in[2])
                       next_state = BYTE2;
                   else
                       next_state = BYTE1;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = DONE;
            DONE: if (in[2])
                      next_state = BYTE2;
                  else
                      next_state = BYTE1;
            default: next_state = BYTE1; // Default state should not be reached
        endcase
    end

    // Combinatorial logic: Output logic
    always @(*) begin
        case (current_state)
            DONE: done = 1;
            default: done = 0;
        endcase
    end

endmodule
