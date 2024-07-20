module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // Define states
    typedef enum logic [1:0] {
        IDLE,    // State 0: Waiting for the first byte with in[3] = 1
        BYTE1,   // State 1: Received first valid byte
        BYTE2,   // State 2: Received second valid byte
        BYTE3    // State 3: Received third valid byte, ready to output
    } state_t;

    state_t state, next_state;
    reg [23:0] message;
    reg [7:0] byte1, byte2, byte3;

    // State transition and output logic
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            done <= 0;
            out_bytes <= 24'bx; // Don't-care state for out_bytes
        end else begin
            state <= next_state;
            case (state)
                IDLE: begin
                    if (in[3] == 1'b1) begin
                        byte1 <= in;
                        next_state <= BYTE1;
                    end else begin
                        next_state <= IDLE;
                    end
                    done <= 0;
                end
                BYTE1: begin
                    byte2 <= in;
                    next_state <= BYTE2;
                    done <= 0;
                end
                BYTE2: begin
                    byte3 <= in;
                    next_state <= BYTE3;
                    done <= 0;
                end
                BYTE3: begin
                    out_bytes <= {byte1, byte2, byte3};
                    done <= 1;
                    next_state <= IDLE;
                end
                default: begin
                    next_state <= IDLE;
                    done <= 0;
                end
            endcase
        end
    end

    // Default next state logic
    always_comb begin
        next_state = state;
        case (state)
            IDLE: begin
                if (in[3] == 1'b1) begin
                    next_state = BYTE1;
                end else begin
                    next_state = IDLE;
                end
            end
            BYTE1: next_state = BYTE2;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = IDLE; // One cycle of done, then reset to IDLE
            default: next_state = IDLE;
        endcase
    end

endmodule
