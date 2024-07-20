module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

reg [2:0] state;
reg done;
wire third_bit;

assign third_bit = in[2];

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= BYTE1;
        done <= 0;
    end else begin
        case (state)
            BYTE1:
                if (third_bit) begin
                    state <= BYTE2;
                end else begin
                    state <= BYTE1;
                end
            BYTE2:
                state <= BYTE3;
            BYTE3:
                state <= DONE;
            DONE:
                if (third_bit) begin
                    state <= BYTE2;
                end else begin
                    state <= BYTE1;
                end
        endcase
    end
end

always @(posedge clk) begin
    if (state == DONE) begin
        done <= 1;
    end else begin
        done <= 0;
    end
end

endmodule
