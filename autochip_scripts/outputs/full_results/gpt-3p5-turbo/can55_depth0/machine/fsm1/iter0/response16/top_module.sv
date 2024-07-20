module top_module (
	input clk,
	input in,
	input areset,
	output out
);

    reg [1:0] state;
    wire next_state;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b1;
        end else begin
            state <= next_state;
        end
    end

    assign next_state = (state == 2'b00 && in) || (state == 2'b01 && !in);

    assign out = (state == 2'b01);

endmodule
