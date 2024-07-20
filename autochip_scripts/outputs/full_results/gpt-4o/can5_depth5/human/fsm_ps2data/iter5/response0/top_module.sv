module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);
    // State definitions
    localparam IDLE = 2'd0, BYTE1 = 2'd1, BYTE2 = 2'd2, BYTE3 = 2'd3;
    reg [1:0] state, next_state;
    reg [23:0] msg;
    reg [7:0] in_reg;

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
            done <= 0;
            msg <= 24'b0;
        end else begin
            case (state)
                IDLE: begin
                    if (in[3] == 1) begin
                        msg[23:16] <= in;
                    end
                    done <= 0;
                end
                BYTE1: begin
                    msg[15:8] <= in;
                    done <= 0;
                end
                BYTE2: begin
                    msg[7:0] <= in;
                    done <= 0;
                end
                BYTE3: begin
                    done <= 1;
                    out_bytes <= msg;
                end
                default: begin
                    done <= 0;
                end
            endcase
        end
    end

    // To reset done flag after it is asserted once
    always @(posedge clk) begin
        if (!reset && state == BYTE3) begin
            done <= 1;
        end else if (done) begin
            done <= 0;
        end
    end

endmodule
