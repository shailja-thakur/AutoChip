module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    reg [1:0] state;
    reg [1:0] next_state;
    reg [23:0] byte_buffer;
    reg [1:0] byte_count;

    // State encoding
    localparam IDLE = 2'b00;
    localparam BYTE1 = 2'b01;
    localparam BYTE2 = 2'b10;
    localparam BYTE3 = 2'b11;

    // State transition
    always @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            IDLE: 
                if (in[3] == 1'b1)
                    next_state = BYTE1;
                else
                    next_state = IDLE;
            BYTE1:
                next_state = BYTE2;
            BYTE2:
                next_state = BYTE3;
            BYTE3:
                next_state = IDLE;
            default:
                next_state = IDLE;
        endcase
    end

    // Output logic and byte capture
    always @(posedge clk) begin
        if (reset) begin
            done <= 0;
            out_bytes <= 24'dx;
            byte_buffer <= 24'd0;
            byte_count <= 2'd0;
        end else begin
            case (state)
                IDLE: begin
                    done <= 0;
                    if (in[3] == 1'b1) begin
                        byte_buffer[23:16] <= in;
                        byte_count <= 2'd1;
                    end
                end
                BYTE1: begin
                    byte_buffer[15:8] <= in;
                    byte_count <= 2'd2;
                end
                BYTE2: begin
                    byte_buffer[7:0] <= in;
                    byte_count <= 2'd3;
                end
                BYTE3: begin
                    out_bytes <= byte_buffer;
                    done <= 1;
                    byte_count <= 2'd0;
                end
                default: begin
                    done <= 0;
                end
            endcase
        end
    end
endmodule
