module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

reg [1:0] state;
reg done_reg;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 2'b0;
    else begin
        case (state)
            2'b00:
                if (in[2] == 1)
                    state <= 2'b01;
            2'b01:
                state <= 2'b10;
            2'b10:
                state <= 2'b11;
            2'b11:
                state <= (in[2] == 0) ? 2'b00 : 2'b01;
        endcase
    end
end

always @(state) begin
    done_reg = (state == 2'b11);
end

assign done = done_reg;

endmodule
