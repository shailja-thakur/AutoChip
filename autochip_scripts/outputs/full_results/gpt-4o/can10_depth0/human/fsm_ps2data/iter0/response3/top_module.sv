module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    reg [1:0] state, next_state;
    reg [23:0] message;

    parameter IDLE = 2'b00;
    parameter BYTE1 = 2'b01;
    parameter BYTE2 = 2'b10;
    parameter BYTE3 = 2'b11;

    // State transition logic
    always @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
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

    // Output and message capture logic
    always @(posedge clk) begin
        if (reset) begin
            out_bytes <= 24'b0;
            message <= 24'b0;
            done <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    done <= 1'b0;
                end
                BYTE1: begin
                    message[23:16] <= in;
                end
                BYTE2: begin
                    message[15:8] <= in;
                end
                BYTE3: begin
                    message[7:0] <= in;
                    out_bytes <= message;
                    done <= 1'b1;
                end
                default: begin
                    done <= 1'b0;
                end
            endcase
        end
    end

endmodule
