module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output [23:0] out_bytes,
    output done
);

reg [3:0] state;
reg [23:0] out_reg;
wire [2:0] third_bit;

assign third_bit = in[2];

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= BYTE1;
        out_reg <= 0;
    end else begin
        case (state)
            BYTE1:
                if (third_bit) begin
                    state <= BYTE2;
                else
                    state <= BYTE1;
                end
            BYTE2:
                state <= BYTE3;
            BYTE3:
                state <= DONE;
            DONE:
                if (!third_bit)
                    state <= BYTE1;
                else
                    state <= DONE;
        endcase
    end
end

always @(posedge clk) begin
    if (state == DONE)
        out_bytes <= out_reg;
end

always @(posedge clk) begin
    out_reg <= {in, out_reg[23:8]};
end

assign done = (state == DONE);

endmodule
