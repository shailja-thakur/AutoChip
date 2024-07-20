module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);
    // State Encoding
    localparam [1:0] 
        IDLE  = 2'b00,
        BYTE1 = 2'b01,
        BYTE2 = 2'b10,
        BYTE3 = 2'b11;

    reg [1:0] state, next_state;
    reg [23:0] byte_buffer;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            done <= 0;
            out_bytes <= 24'bx; // Undefined during reset
        end else begin
            state <= next_state;
            case (state)
                IDLE: begin
                    done <= 0;
                    if (in[3] == 1) begin
                        byte_buffer[23:16] <= in;
                        out_bytes <= 24'bx; // Don't-care condition
                    end
                end

                BYTE1: begin
                    done <= 0;
                    byte_buffer[15:8] <= in;
                    out_bytes <= 24'bx; // Don't-care condition
                end

                BYTE2: begin
                    done <= 0;
                    byte_buffer[7:0] <= in;
                    out_bytes <= 24'bx; // Don't-care condition
                end

                BYTE3: begin
                    done <= 1;
                    out_bytes <= byte_buffer;
                end

                default: begin
                    done <= 0;
                    out_bytes <= 24'bx; // Don't care condition
                end
            endcase
        end
    end

    // Next State Logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (in[3] == 1)
                    next_state = BYTE1;
                else
                    next_state = IDLE;
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

endmodule
