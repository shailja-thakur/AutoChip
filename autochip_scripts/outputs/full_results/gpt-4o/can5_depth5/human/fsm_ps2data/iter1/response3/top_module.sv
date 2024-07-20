module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // State definitions
    localparam IDLE = 2'b00, BYTE1 = 2'b01, BYTE2 = 2'b10, BYTE3 = 2'b11;
    reg [1:0] state, next_state;
    reg [7:0] byte1, byte2, byte3;

    // State register
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
                if (in[3] == 1'b1)
                    next_state = BYTE1;
                else
                    next_state = IDLE;
            end
            BYTE1: next_state = BYTE2;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

    // Output and register update
    always @(posedge clk) begin
        if (reset) begin
            byte1 <= 8'b0;
            byte2 <= 8'b0;
            byte3 <= 8'b0;
            out_bytes <= 24'b0;
            done <= 0;
        end else begin
            done <= 0; // Default to 0 unless in the BYTE3 state
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
                    out_bytes <= {byte1, byte2, in}; // Concatenate stored bytes with current input byte
                    done <= 1;
                end
                default: begin
                    // Do nothing
                end
            endcase
        end
    end

endmodule
