module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);
    // State definitions
    localparam BYTE1 = 2'b00;
    localparam BYTE2 = 2'b01;
    localparam BYTE3 = 2'b10;
    localparam DONE = 2'b11;

    // State register
    reg [1:0] state;
    reg done_delay; // Added delay to done signal to make sure out_bytes is updated

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= BYTE1;
            out_bytes <= 0;
            done <= 0;
            done_delay <= 0;
        end else begin
            case (state)
                BYTE1:
                    begin
                        if (in[2] == 1)
                            state <= BYTE2;
                        else
                            state <= BYTE1;
                    end
                BYTE2:
                    begin
                        if (in[2] == 1)
                            state <= BYTE3;
                        else
                            state <= BYTE1;
                    end
                BYTE3:
                    begin
                        if (in[2] == 1)
                            state <= DONE;
                        else
                            state <= BYTE1;
                    end
                DONE:
                    begin
                        if (in[2] == 0)
                            state <= BYTE1;
                        else
                            state <= DONE;
                    end
            endcase
        end
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            out_bytes <= 0;
            done <= 0;
        end else if (state == DONE && done_delay) begin
            out_bytes <= out_bytes;
            done <= 1;
        end else begin
            out_bytes <= {out_bytes[15:0], in};
            done <= 0;
        end
        done_delay <= done;
    end

endmodule
