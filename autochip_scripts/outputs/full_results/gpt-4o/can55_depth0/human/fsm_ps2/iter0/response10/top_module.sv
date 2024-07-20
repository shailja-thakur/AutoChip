module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    typedef enum reg [1:0] {
        IDLE = 2'b00,    // Waiting for the first byte with in[3] = 1
        BYTE1 = 2'b01,   // First byte received
        BYTE2 = 2'b10,   // Second byte received
        BYTE3 = 2'b11    // Third byte received
    } state_t;

    state_t state, next_state;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        // Default assignments
        done = 0;
        next_state = state;

        case (state)
            IDLE: begin
                if (in[3]) begin
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
                done = 1;
                if (in[3]) begin
                    next_state = BYTE1; // If the next byte already has in[3]=1, start new message without going to IDLE.
                end else begin
                    next_state = IDLE;
                end
            end
        endcase
    end

endmodule
