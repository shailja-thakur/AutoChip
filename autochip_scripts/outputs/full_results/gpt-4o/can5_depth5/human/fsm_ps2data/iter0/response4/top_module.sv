module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // State encoding
    typedef enum logic [1:0] {
        IDLE,          // Waiting for the first byte with in[3] = 1
        BYTE1,         // First byte received
        BYTE2,         // Second byte received
        BYTE3          // Third byte received
    } state_t;
    
    state_t state, next_state;
    reg [23:0] shift_reg;

    // State register with synchronous reset
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            shift_reg <= 24'd0;
            done <= 1'b0;
        end else begin
            state <= next_state;
            if (state == BYTE3) begin
                out_bytes <= shift_reg;
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
        end
    end

    // Next state logic
    always @(*) begin
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
                if (in[3]) begin
                    next_state = BYTE1; // Reset to BYTE1 if new message starts immediately
                end else begin
                    next_state = IDLE; // Go to IDLE if no new message starts
                end
            end
        endcase
    end

    // Output logic and shift register update
    always @(posedge clk) begin
        if (state != IDLE) begin
            shift_reg <= {shift_reg[15:0], in};
        end
    end

endmodule
