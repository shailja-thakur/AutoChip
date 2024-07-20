module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    reg [1:0] state, next_state;
    reg [23:0] message;

    // State encoding
    localparam WAIT_HEADER = 2'd0,
               BYTE_1 = 2'd1,
               BYTE_2 = 2'd2,
               BYTE_3 = 2'd3;

    // State transition logic
    always @(*) begin
        case (state)
            WAIT_HEADER: begin
                if (in[3])
                    next_state = BYTE_1;
                else
                    next_state = WAIT_HEADER;
            end
            BYTE_1: next_state = BYTE_2;
            BYTE_2: next_state = BYTE_3;
            BYTE_3: next_state = WAIT_HEADER;
            default: next_state = WAIT_HEADER;
        endcase
    end

    // State update and output logic
    always @(posedge clk) begin
        if (reset) begin
            state <= WAIT_HEADER;
            message <= 24'b0;
            out_bytes <= 24'b0;
            done <= 1'b0;
        end else begin
            state <= next_state;
            case (next_state)
                WAIT_HEADER: begin
                    done <= 1'b0;
                end
                BYTE_1: begin
                    message[23:16] <= in;
                end
                BYTE_2: begin
                    message[15:8] <= in;
                end
                BYTE_3: begin
                    message[7:0] <= in;
                    out_bytes <= {message[23:16], message[15:8], in};
                    done <= 1'b1;
                end
            endcase
        end
    end
endmodule
