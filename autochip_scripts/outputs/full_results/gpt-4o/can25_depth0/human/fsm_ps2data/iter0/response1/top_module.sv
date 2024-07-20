module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);
    reg [2:0] state, next_state;
    reg [23:0] message;

    localparam IDLE = 3'b000,
               BYTE1 = 3'b001,
               BYTE2 = 3'b010,
               BYTE3 = 3'b011;

    // State transition
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
                if (in[3] == 1) begin
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

    // Output logic and message assembly
    always @(posedge clk) begin
        if (reset) begin
            out_bytes <= 24'b0;
            done <= 0;
            message <= 24'b0;
        end else begin
            done <= 0;
            case (state)
                BYTE1: begin
                    message[23:16] <= in;
                end
                BYTE2: begin
                    message[15:8] <= in;
                end
                BYTE3: begin
                    message[7:0] <= in;
                    out_bytes <= {message[23:16], message[15:8], in};
                    done <= 1;
                end
                default: begin
                    message <= 24'b0;
                end
            endcase
        end
    end
endmodule
