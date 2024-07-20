module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

reg [1:0] state;
localparam BYTE1 = 2'b00, BYTE2 = 2'b01, BYTE3 = 2'b10, DONE = 2'b11;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= BYTE1;
        out_bytes <= 24'b0;
        done <= 1'b0;
    end
    else begin
        case (state)
            BYTE1: begin
                out_bytes <= {out_bytes[15:0], in};
                if (in[2]) begin
                    state <= BYTE2;
                end
                else begin
                    state <= BYTE1;
                end
            end
            BYTE2: begin
                out_bytes <= {out_bytes[15:0], in};
                state <= BYTE3;
            end
            BYTE3: begin
                out_bytes <= {out_bytes[7:0], in};
                state <= DONE;
            end
            DONE: begin
                done <= 1'b1;
                if (in[2]) begin
                    state <= BYTE1;
                    done <= 1'b0;
                end
                else begin
                    state <= BYTE1;
                    done <= 1'b0;
                end
            end
            default: begin
                state <= BYTE1;
            end
        endcase
    end
end

endmodule
