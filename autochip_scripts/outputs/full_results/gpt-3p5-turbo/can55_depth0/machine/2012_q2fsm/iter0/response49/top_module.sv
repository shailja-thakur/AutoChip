module top_module (
    input clk,
    input reset,
    input w,
    output z
);

reg [2:0] state;
assign z = (state == 3'b110) || (state == 3'b111);

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 3'b000;
    else begin
        case (state)
            3'b000: if (w == 1'b0) state <= 3'b000; else state <= 3'b001;
            3'b001: if (w == 1'b0) state <= 3'b010; else state <= 3'b011;
            3'b010: if (w == 1'b0) state <= 3'b010; else state <= 3'b110;
            3'b011: if (w == 1'b0) state <= 3'b000; else state <= 3'b111;
            3'b110: if (w == 1'b0) state <= 3'b011; else state <= 3'b110;
            3'b111: if (w == 1'b0) state <= 3'b011; else state <= 3'b010;
        endcase
    end
end

endmodule
