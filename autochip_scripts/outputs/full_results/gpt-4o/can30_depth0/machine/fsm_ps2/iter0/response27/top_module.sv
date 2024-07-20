module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    // Define state encoding
    typedef enum logic [1:0] {
        BYTE1 = 2'b00,
        BYTE2 = 2'b01,
        BYTE3 = 2'b10,
        DONE  = 2'b11
    } state_t;

    // Declare current state and next state variables
    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= BYTE1;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic and output logic
    always_comb begin
        // Default values
        next_state = current_state;
        done = 1'b0;

        case (current_state)
            BYTE1: begin
                if (in[2] == 1'b1) begin
                    next_state = BYTE2;
                end
            end
            BYTE2: begin
                next_state = BYTE3;
            end
            BYTE3: begin
                next_state = DONE;
            end
            DONE: begin
                done = 1'b1;
                if (in[2] == 1'b0) begin
                    next_state = BYTE1;
                end else begin
                    next_state = BYTE2;
                end
            end
        endcase
    end
endmodule
