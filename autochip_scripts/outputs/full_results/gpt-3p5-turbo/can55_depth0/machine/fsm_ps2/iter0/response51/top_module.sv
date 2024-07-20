module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [1:0] state;
assign done = (state == 2'b11);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 2'b00;
    end else begin
        case (state)
            2'b00: begin
                if (in[2] == 1'b1) begin
                    state <= 2'b01;
                end
            end
            2'b01: begin
                state <= 2'b10;
            end
            2'b10: begin
                state <= 2'b11;
            end
            2'b11: begin
                if (in[2] == 1'b0) begin
                    state <= 2'b00;
                end else begin
                    state <= 2'b01;
                end
            end
        endcase
    end
end

endmodule
