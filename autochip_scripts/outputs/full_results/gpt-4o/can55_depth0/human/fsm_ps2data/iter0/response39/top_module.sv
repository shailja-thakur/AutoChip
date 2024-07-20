module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // State declaration
    typedef enum reg [1:0] {IDLE, BYTE1, BYTE2, BYTE3} state_t;
    state_t state, next_state;

    // Byte storage
    reg [7:0] byte1, byte2, byte3;

    // State Transition
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
                if (in[3] == 1'b1) begin
                    next_state = BYTE1;
                end else begin
                    next_state = IDLE;
                end
            end
            BYTE1: next_state = BYTE2;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

    // Output logic and byte storage
    always @(posedge clk) begin
        if (reset) begin
            done <= 1'b0;
            out_bytes <= 24'b0;
            byte1 <= 8'b0;
            byte2 <= 8'b0;
            byte3 <= 8'b0;
        end else begin
            done <= 1'b0;  // default to 0
            case (state)
                IDLE: begin
                    // Do nothing
                end
                BYTE1: begin
                    byte1 <= in;
                end
                BYTE2: begin
                    byte2 <= in;
                end
                BYTE3: begin
                    byte3 <= in;
                    out_bytes <= {byte1, byte2, byte3};
                    done <= 1'b1;
                end
                default: begin
                    // Do nothing
                end
            endcase
        end
    end

endmodule
