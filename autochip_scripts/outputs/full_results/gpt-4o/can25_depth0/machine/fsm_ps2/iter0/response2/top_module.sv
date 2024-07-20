module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    // State declarations
    typedef enum logic [1:0] {
        BYTE1 = 2'b00,
        BYTE2 = 2'b01,
        BYTE3 = 2'b10,
        DONE  = 2'b11
    } state_t;

    state_t current_state, next_state;

    // Sequential logic for state transitions
    always @(posedge clk or posedge reset) begin
        if (reset) 
            current_state <= BYTE1;
        else 
            current_state <= next_state;
    end

    // Combinational logic for next state and output logic
    always @(*) begin
        // Default next state and done signal
        next_state = current_state;
        done = 1'b0;

        case (current_state)
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
                done = 1'b1; // Assert done signal
                if (in[2] == 1'b0)
                    next_state = BYTE1;
                else
                    next_state = BYTE2;
            end

            default: next_state = BYTE1; // Default state transition
        endcase
    end

endmodule
