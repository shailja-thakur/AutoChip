module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

localparam STATE_SEARCH = 0,
          STATE_RECEIVE = 1;

reg [1:0] state;
reg [2:0] byte_count;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_SEARCH;
        byte_count <= 3'b000;
        out_bytes <= 24'h000000;
        done <= 1'b0;
    end
    else begin
        case (state)
            STATE_SEARCH: begin
                if (in[3]) begin
                    state <= STATE_RECEIVE;
                    byte_count <= 3'b001;
                end
            end
            STATE_RECEIVE: begin
                out_bytes[23:16] <= out_bytes[15:8];
                out_bytes[15:8] <= out_bytes[7:0];
                out_bytes[7:0] <= in;
                byte_count <= byte_count + 1'b1;
                if (byte_count == 3'b011) begin
                    state <= STATE_SEARCH;
                    done <= 1'b1;
                end
                else begin
                    done <= 1'b0;
                end
            end
        endcase
    end
end

endmodule
