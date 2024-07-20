module top_module (
    input clk,
    input in,
    input reset,
    output out
);

reg [1:0] state;
wire next_state;
reg out_reg;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 2'b0;
        out_reg <= 1'b1;
    end else begin
        state <= next_state;
        out_reg <= (state == 2'b01) ? 1'b0 : 1'b1;
    end
end

assign next_state = (state == 2'b00 && in) ? 2'b10 :
                   (state == 2'b00 && !in) ? 2'b00 :
                   (state == 2'b01 && in) ? 2'b01 :
                   (state == 2'b01 && !in) ? 2'b00 : 2'b00;

assign out = out_reg;

endmodule
