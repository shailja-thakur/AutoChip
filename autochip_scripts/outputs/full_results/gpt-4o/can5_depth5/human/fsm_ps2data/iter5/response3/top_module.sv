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

    // Byte count register
    reg [23:0] message;
    reg [1:0] byte_count;

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
                if (in[3] == 1)
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

    // Output and message register update
    always @(posedge clk) begin
        if (reset) begin
            out_bytes <= 24'b0;
            message <= 24'b0;
            done <= 0;
            byte_count <= 0;
        end else begin
            done <= 0; // Default value

            case (state)
                IDLE: begin
                    if (in[3] == 1) begin
                        message[23:16] <= in;
                        byte_count <= 1;
                    end
                end
                BYTE1: begin
                    message[15:8] <= in;
                    byte_count <= 2;
                end
                BYTE2: begin
                    message[7:0] <= in;
                    byte_count <= 3;
                end
                BYTE3: begin
                    done <= 1;
                    out_bytes <= message;
                end
            endcase
        end
    end
endmodule
