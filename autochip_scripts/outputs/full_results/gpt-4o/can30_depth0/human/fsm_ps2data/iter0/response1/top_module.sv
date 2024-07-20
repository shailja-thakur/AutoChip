module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);
    // State declaration
    typedef enum reg [1:0] {
        IDLE = 2'b00,
        BYTE_1 = 2'b01,
        BYTE_2 = 2'b10,
        BYTE_3 = 2'b11
    } state_t;

    state_t current_state, next_state;

    // Next state logic
    always @(*) begin
        case (current_state)
            IDLE: next_state = in[3] ? BYTE_1 : IDLE;
            BYTE_1: next_state = BYTE_2;
            BYTE_2: next_state = BYTE_3;
            BYTE_3: next_state = in[3] ? BYTE_1 : IDLE; // Transition to BYTE_1 if a new message starts
            default: next_state = IDLE;
        endcase
    end

    // State transition
    always @(posedge clk) begin
        if (reset)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    // Output logic
    always @(posedge clk) begin
        if (reset) begin
            done <= 0;
            out_bytes <= 24'b0;
        end
        else begin
            done <= 0; // Default no done signal
            case (current_state)
                IDLE: ; // Do nothing
                BYTE_1: out_bytes[23:16] <= in;
                BYTE_2: out_bytes[15:8] <= in;
                BYTE_3: begin
                    out_bytes[7:0] <= in;
                    done <= 1; // Signal done once 3 bytes are collected
                end
            endcase
        end
    end
endmodule
