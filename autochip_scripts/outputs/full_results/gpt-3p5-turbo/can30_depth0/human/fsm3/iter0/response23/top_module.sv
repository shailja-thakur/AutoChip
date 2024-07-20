module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg [1:0] state;
wire [1:0] next_state;
reg out_reg;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 0;
        out_reg <= 0;
    end else begin
        state <= next_state;
        out_reg <= (state == 3) ? 1'b1 : 1'b0;
    end
end

assign next_state[1] = (in == 1'b0) ? state[1] : state[0];
assign next_state[0] = (in == 1'b0) ? state[0] : (state[1] == 1'b1) ? 1'b1 : 1'b0;

assign out = out_reg;

endmodule
