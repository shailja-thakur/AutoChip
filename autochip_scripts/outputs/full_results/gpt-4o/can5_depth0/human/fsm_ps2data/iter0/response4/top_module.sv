module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // Define the states for the FSM
    typedef enum reg [1:0] {
        IDLE = 2'b00,       // Waiting for in[3] = 1
        BYTE1 = 2'b01,      // First byte received
        BYTE2 = 2'b10,      // Second byte received
        BYTE3 = 2'b11       // Third byte received
    } state_t;

    state_t state, next_state;

    // Output byte registers
    reg [7:0] byte1, byte2, byte3;

    // State transition
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (in[3]) begin
                    next_state = BYTE1;
                end else begin
                    next_state = IDLE;
                end
            end
            BYTE1: next_state = BYTE2;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = IDLE; // After third byte, go back to IDLE
            default: next_state = IDLE;
        endcase
    end

    // Output logic and byte capture
    always @(posedge clk) begin
        if (reset) begin
            byte1 <= 8'b0;
            byte2 <= 8'b0;
            byte3 <= 8'b0;
            out_bytes <= 24'b0;
            done <= 1'b0;
        end else begin
            case (next_state)
                IDLE: begin
                    done <= 1'b0;
                end
                BYTE1: begin
                    byte1 <= in;
                end
                BYTE2: begin
                    byte2 <= in;
                end
                BYTE3: begin
                    byte3 <= in;
                    out_bytes <= {byte1, byte2, in}; // Concatenate bytes
                    done <= 1'b1; // Signal done after third byte
                end
            endcase

            // Reset done signal one cycle after it is set
            if (done && state != BYTE3)
                done <= 1'b0;
        end
    end

endmodule
