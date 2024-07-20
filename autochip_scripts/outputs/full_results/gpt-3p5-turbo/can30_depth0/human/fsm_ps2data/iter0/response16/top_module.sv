module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

reg [7:0] byte1;
reg [7:0] byte2;

reg [1:0] state;
parameter IDLE = 2'b00;
parameter SEARCH_BYTE1 = 2'b01;
parameter SEARCH_BYTE2 = 2'b10;

always @(posedge clk) begin
    if (reset) begin
        byte1 <= 8'b0;
        byte2 <= 8'b0;
        out_bytes <= 24'b0;
        done <= 1'b0;
        state <= IDLE;
    end else begin
        case (state)
            IDLE:
                if (in[3]) begin
                    byte1 <= in;
                    state <= SEARCH_BYTE1;
                end
            SEARCH_BYTE1:
                if (in[3]) begin
                    byte1 <= in;
                end else begin
                    byte2 <= in;
                    state <= SEARCH_BYTE2;
                end
            SEARCH_BYTE2:
                if (in[3]) begin
                    byte1 <= in;
                    state <= SEARCH_BYTE1;
                end else begin
                    out_bytes <= {byte1, byte2, in};
                    done <= 1'b1;
                    state <= IDLE;
                end
        endcase
    end
end

endmodule
