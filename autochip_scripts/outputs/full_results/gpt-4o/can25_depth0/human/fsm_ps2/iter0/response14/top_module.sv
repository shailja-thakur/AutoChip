module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    // Define states
    typedef enum reg [1:0] {
        IDLE = 2'd0,   // Initial state, waiting for in[3]=1
        BYTE1 = 2'd1,  // Found the first byte
        BYTE2 = 2'd2,  // Found the second byte
        BYTE3 = 2'd3   // Found the third byte
    } state_t;

    // FSM current state and next state registers
    reg [1:0] current_state, next_state;

    // Synchronous state transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    // Combinational logic for state transition and output
    always @(*) begin
        // Default values
        next_state = current_state;
        done = 1'b0;

        case (current_state)
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
                    next_state = BYTE1;
                end else begin
                    next_state = IDLE;
                end
            end

            default: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule
