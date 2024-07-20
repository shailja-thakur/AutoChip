module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // Define FSM states
    typedef enum {
        WAIT_FOR_START,
        BYTE_1,
        BYTE_2,
        BYTE_3
    } fsm_state_t;

    fsm_state_t state, next_state;

    // Registers to hold incoming bytes
    reg [7:0] byte1, byte2, byte3;

    // State register sequential logic
    always @(posedge clk) begin
        if (reset)
            state <= WAIT_FOR_START;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            WAIT_FOR_START: begin
                if (in[3])
                    next_state = BYTE_1;
                else
                    next_state = WAIT_FOR_START;
            end
            BYTE_1: begin
                next_state = BYTE_2;
            end
            BYTE_2: begin
                next_state = BYTE_3;
            end
            BYTE_3: begin
                next_state = WAIT_FOR_START;
            end
            default: begin
                next_state = WAIT_FOR_START;
            end
        endcase
    end

    // Output logic and data path logic
    always @(posedge clk) begin
        if (reset) begin
            done <= 0;
            out_bytes <= 24'b0;
            byte1 <= 8'b0;
            byte2 <= 8'b0;
            byte3 <= 8'b0;
        end else begin
            done <= 0; // Default value
            case (state)
                WAIT_FOR_START: begin
                    // No action needed
                end
                BYTE_1: begin
                    byte1 <= in;
                end
                BYTE_2: begin
                    byte2 <= in;
                end
                BYTE_3: begin
                    byte3 <= in;
                    out_bytes <= {byte1, byte2, byte3};
                    done <= 1; // Signal done in the cycle immediately after the third byte is received
                end
            endcase
        end
    end

endmodule
