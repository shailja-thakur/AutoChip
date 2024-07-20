module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    reg [2:0] state, next_state;
    reg [23:0] byte_buffer;

    // State encoding
    localparam WAIT_FOR_1ST_BYTE = 3'd0,
               WAIT_FOR_2ND_BYTE = 3'd1,
               WAIT_FOR_3RD_BYTE = 3'd2,
               DONE_STATE = 3'd3;

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= WAIT_FOR_1ST_BYTE;
            done <= 0;
            byte_buffer <= 24'd0;
        end else begin
            state <= next_state;

            if (next_state == DONE_STATE) begin
                done <= 1;
                out_bytes <= byte_buffer;
            end else begin
                done <= 0;
            end
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            WAIT_FOR_1ST_BYTE: begin
                if (in[3] == 1) begin
                    next_state = WAIT_FOR_2ND_BYTE;
                end else begin
                    next_state = WAIT_FOR_1ST_BYTE;
                end
            end
            WAIT_FOR_2ND_BYTE: begin
                next_state = WAIT_FOR_3RD_BYTE;
            end
            WAIT_FOR_3RD_BYTE: begin
                next_state = DONE_STATE;
            end
            DONE_STATE: begin
                if (in[3] == 1) begin
                    next_state = WAIT_FOR_2ND_BYTE;
                end else begin
                    next_state = WAIT_FOR_1ST_BYTE;
                end
            end
            default: begin
                next_state = WAIT_FOR_1ST_BYTE;
            end
        endcase
    end

    // Byte buffer logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            byte_buffer <= 24'd0;
        end else begin
            case (state)
                WAIT_FOR_1ST_BYTE: begin
                    if (in[3] == 1) begin
                        byte_buffer[23:16] <= in;
                    end
                end
                WAIT_FOR_2ND_BYTE: begin
                    byte_buffer[15:8] <= in;
                end
                WAIT_FOR_3RD_BYTE: begin
                    byte_buffer[7:0] <= in;
                end
                default: begin
                    // Do nothing
                end
            endcase
        end
    end

endmodule
