module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);
    // Declare states
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        BYTE1 = 2'b01,
        BYTE2 = 2'b10,
        BYTE3 = 2'b11
    } state_t;

    state_t state, next_state;

    // Byte registers
    reg [7:0] byte1, byte2, byte3;

    // State transition
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (state)
            IDLE: begin
                if (in[3] == 1'b1) begin
                    next_state = BYTE1;
                end else begin
                    next_state = IDLE;
                end
            end
            BYTE1: begin
                next_state = BYTE2;
            end
            BYTE2: begin
                next_state = BYTE3;
            end
            BYTE3: begin
                next_state = IDLE;
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

    // Output and byte register assignments
    always_ff @(posedge clk) begin
        if (reset) begin
            done <= 1'b0;
            out_bytes <= 24'b0;
            byte1 <= 8'b0;
            byte2 <= 8'b0;
            byte3 <= 8'b0;
        end else begin
            done <= 1'b0; // Default case
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
                    done <= 1'b1;
                    out_bytes <= {byte1, byte2, byte3};
                end
            endcase
        end
    end
endmodule
