module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output [23:0] out_bytes,
    output done
);

reg [2:0] state;
reg [23:0] out_reg;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= BYTE1;
        out_reg <= 0;
    end else begin
        case(state)
            BYTE1:
                if (in[2] == 1) begin
                    state <= BYTE2;
                    out_reg <= {out_reg[15:0], in};
                end else begin
                    state <= BYTE1;
                    out_reg <= {out_reg[15:0], in};
                end
            BYTE2:
                state <= BYTE3;
                out_reg <= {out_reg[7:0], in};
            BYTE3:
                state <= DONE;
                out_reg <= {out_reg[7:0], in};
            DONE:
                if (in[2] == 0) begin
                    state <= BYTE1;
                    out_reg <= {out_reg[15:0], in};
                end else begin
                    state <= DONE;
                    out_reg <= out_reg;
                end
        endcase
    end
end

assign out_bytes = (done) ? out_reg : 0;
assign done = (state == DONE);

endmodule
