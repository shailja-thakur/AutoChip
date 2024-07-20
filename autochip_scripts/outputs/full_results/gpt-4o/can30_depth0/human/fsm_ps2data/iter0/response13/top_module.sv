module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    reg [1:0] state, next_state;
    reg [23:0] byte_buffer;

    // State encoding
    localparam IDLE       = 2'b00,
               BYTE_1     = 2'b01,
               BYTE_2     = 2'b10,
               BYTE_3     = 2'b11;

    // State transition
    always @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case(state)
            IDLE: begin
                if (in[3] == 1)
                    next_state = BYTE_1;
                else
                    next_state = IDLE;
            end
            BYTE_1: next_state = BYTE_2;
            BYTE_2: next_state = BYTE_3;
            BYTE_3: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

    // Output logic and byte buffering
    always @(posedge clk) begin
        if (reset) begin
            byte_buffer <= 24'b0;
            out_bytes <= 24'b0;
            done <= 1'b0;
        end
        else begin
            done <= 1'b0;  // Default done to 0

            case(state)
                IDLE: begin
                    if (in[3] == 1)
                        byte_buffer <= {16'b0, in};
                end
                BYTE_1: byte_buffer <= {byte_buffer[23:16], in};
                BYTE_2: byte_buffer <= {byte_buffer[23:8], in};
                BYTE_3: begin
                    byte_buffer <= {byte_buffer[23:8], in};
                    out_bytes <= {byte_buffer[23:8], in};
                    done <= 1'b1;
                end
            endcase
        end
    end
endmodule
