module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

localparam IDLE = 2'b00;
localparam MSG_RECV = 2'b01;
localparam MSG_DONE = 2'b10;

reg [1:0] state;
reg [1:0] bit_count;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        out_bytes <= 0;
        done <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (in[3]) begin
                    state <= MSG_RECV;
                    bit_count <= 1;
                    out_bytes <= {in, 16'b0};
                end else begin
                    state <= IDLE;
                    bit_count <= 0;
                    out_bytes <= 0;
                    done <= 0;
                end
            end
            MSG_RECV: begin
                out_bytes <= {out_bytes[15:0], in};
                bit_count <= bit_count + 1;
                if (bit_count == 2) begin
                    state <= MSG_DONE;
                    done <= 1;
                end else begin
                    state <= MSG_RECV;
                    done <= 0;
                end
            end
            MSG_DONE: begin
                state <= IDLE;
                bit_count <= 0;
                done <= 0;
            end
            default: begin
                state <= IDLE;
                bit_count <= 0;
                out_bytes <= 0;
                done <= 0;
            end
        endcase
    end
end

endmodule
