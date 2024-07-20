module top_module (
    input clk,
    input reset,
    input w,
    output z
);

reg [2:0] state;
assign z = (state == 3'b100) || (state == 3'b101);

always @(posedge clk) begin
    if (reset) begin
        state <= 3'b00;
    end else begin
        case (state)
            3'b000 : begin
                if (w) begin
                    state <= 3'b01;
                end else begin
                    state <= 3'b00;
                end
            end
            3'b001 : begin
                if (w) begin
                    state <= 3'b10;
                end else begin
                    state <= 3'b11;
                end
            end
            3'b010 : begin
                if (w) begin
                    state <= 3'b100;
                end else begin
                    state <= 3'b11;
                end
            end
            3'b011 : begin
                if (w) begin
                    state <= 3'b101;
                end else begin
                    state <= 3'b00;
                end
            end
            3'b100 : begin
                if (w) begin
                    state <= 3'b100;
                end else begin
                    state <= 3'b110;
                end
            end
            3'b101 : begin
                if (w) begin
                    state <= 3'b111;
                end else begin
                    state <= 3'b010;
                end
            end
            default : state <= 3'b00;
        endcase
    end
end

endmodule
