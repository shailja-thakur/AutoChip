module top_module (
    input clk,
    input reset,
    input w,
    output z
);

reg [2:0] state;
assign z = (state == 3'b100 || state == 3'b101) ? 1'b1 : 1'b0;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 3'b000;
    else begin
        case (state)
            3'b000:
                state <= (w == 1'b0) ? 3'b000 : 3'b001;
            3'b001:
                state <= (w == 1'b0) ? 3'b011 : 3'b010;
            3'b010:
                state <= (w == 1'b0) ? 3'b011 : 3'b100;
            3'b011:
                state <= (w == 1'b0) ? 3'b000 : 3'b110;
            3'b100:
                state <= (w == 1'b0) ? 3'b011 : 3'b100;
            3'b101:
                state <= (w == 1'b0) ? 3'b011 : 3'b110;
        endcase
    end
end

endmodule
