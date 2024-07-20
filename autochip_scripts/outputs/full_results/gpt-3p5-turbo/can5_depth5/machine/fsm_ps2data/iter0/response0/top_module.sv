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

    always @(posedge clk) begin
        if (reset) begin
            state <= BYTE1;
            out_bytes <= 0;
            done <= 0;
        end else begin
            case (state)
                BYTE1:
                    if (in[2] == 1) begin
                        state <= BYTE2;
                    end
                    else begin
                        state <= BYTE1;
                    end
                BYTE2:
                    if (in[2] == 1) begin
                        state <= BYTE3;
                    end
                    else begin
                        state <= BYTE1;
                    end
                BYTE3:
                    if (in[2] == 1) begin
                        state <= DONE;
                    end
                    else begin
                        state <= BYTE1;
                    end
                DONE:
                    if (in[2] == 0) begin
                        state <= BYTE1;
                    end
                    else begin
                        state <= DONE;
                    end
            endcase
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            out_bytes <= 0;
        end else if (state == DONE) begin
            out_bytes <= out_bytes;
        end else begin
            out_bytes <= {out_bytes[15:0], in};
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            done <= 0;
        end else if (state == DONE) begin
            done <= 1;
        end else begin
            done <= 0;
        end
    end

endmodule
