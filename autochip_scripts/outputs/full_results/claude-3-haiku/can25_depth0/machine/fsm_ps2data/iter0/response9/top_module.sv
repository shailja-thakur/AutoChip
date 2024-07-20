module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

reg [1:0] state;
parameter BYTE1 = 2'd0, BYTE2 = 2'd1, BYTE3 = 2'd2, DONE = 2'd3;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= BYTE1;
        out_bytes <= 0;
        done <= 0;
    end
    else begin
        case (state)
            BYTE1: begin
                if (in[2]) begin
                    state <= BYTE2;
                    out_bytes <= {out_bytes[15:0], in};
                end
                else begin
                    state <= BYTE1;
                    out_bytes <= {out_bytes[15:0], in};
                end
                done <= 0;
            end
            BYTE2: begin
                state <= BYTE3;
                out_bytes <= {out_bytes[7:0], in, out_bytes[23:16]};
                done <= 0;
            end
            BYTE3: begin
                state <= DONE;
                out_bytes <= {in, out_bytes[23:8]};
                done <= 0;
            end
            DONE: begin
                if (in[2]) begin
                    state <= BYTE1;
                    out_bytes <= 0;
                end
                else begin
                    state <= BYTE1;
                    out_bytes <= out_bytes;
                end
                done <= 1;
            end
        endcase
    end
end

endmodule
