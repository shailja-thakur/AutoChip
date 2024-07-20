module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

reg [1:0] state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 2'b0;
    end else begin
        case (state)
            2'b0: begin
                if (s) begin
                    state <= 2'b1;
                end else begin
                    state <= 2'b0;
                end
            end
            2'b1: begin
                if (w) begin
                    state <= 2'b10;
                end else begin
                    state <= 2'b1;
                end
            end
            2'b10: begin
                if (w) begin
                    state <= 2'b11;
                end else begin
                    state <= 2'b10;
                end
            end
            2'b11: begin
                if (w) begin
                    state <= 2'b100;
                end else begin
                    state <= 2'b11;
                end
            end
            2'b100: begin
                if (w) begin
                    state <= 2'b101;
                end else begin
                    state <= 2'b100;
                end
            end
            2'b101: begin
                if (w) begin
                    state <= 2'b110;
                end else begin
                    state <= 2'b101;
                end
            end
            2'b110: begin
                if (w) begin
                    state <= 2'b111;
                end else begin
                    state <= 2'b110;
                end
            end
            2'b111: begin
                if (w) begin
                    state <= 2'b10;
                    z <= 1;
                end else begin
                    state <= 2'b111;
                end
            end
        endcase
    end
end

endmodule
