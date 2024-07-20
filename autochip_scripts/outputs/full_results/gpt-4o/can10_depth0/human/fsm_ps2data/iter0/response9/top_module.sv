module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    reg [1:0] state, next_state;
    reg [7:0] byte1, byte2, byte3;

    // State encoding
    localparam IDLE = 2'd0,
               BYTE1 = 2'd1,
               BYTE2 = 2'd2,
               BYTE3 = 2'd3;

    // State register
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            done <= 1'b0;
            byte1 <= 8'd0;
            byte2 <= 8'd0;
            byte3 <= 8'd0;
            out_bytes <= 24'd0;
        end else begin
            state <= next_state;
            case (next_state)
                BYTE1: byte1 <= in;
                BYTE2: byte2 <= in;
                BYTE3: begin
                    byte3 <= in;
                    out_bytes <= {byte1, byte2, byte3};
                    done <= 1'b1;
                end
                default: done <= 1'b0;
            endcase
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            IDLE:  if (in[3]) next_state = BYTE1;
                   else next_state = IDLE;
            BYTE1: next_state = BYTE2;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

endmodule
