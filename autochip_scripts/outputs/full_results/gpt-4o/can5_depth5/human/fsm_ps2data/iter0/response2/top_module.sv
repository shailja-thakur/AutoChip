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
    reg [23:0] message_reg;

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
            message_reg <= 24'b0;
            out_bytes <= 24'b0;
            done <= 0;
        end else begin
            case (state)
                IDLE: begin
                    done <= 0;
                end
                BYTE1: begin
                    message_reg[23:16] <= in;
                end
                BYTE2: begin
                    message_reg[15:8] <= in;
                end
                BYTE3: begin
                    message_reg[7:0] <= in;
                    out_bytes <= {message_reg[23:8], in}; // Concatenate stored bytes with current input byte
                    done <= 1;
                end
                default: begin
                    done <= 0;
                end
            endcase
        end
    end

endmodule
