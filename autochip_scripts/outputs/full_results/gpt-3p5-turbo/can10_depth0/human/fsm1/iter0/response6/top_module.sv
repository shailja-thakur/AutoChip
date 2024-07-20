module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg [1:0] state, next_state;

parameter B = 2'b00, A = 2'b01;

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= B;
    else
        state <= next_state;
end

always @* begin
    case (state)
        B: begin
            if (in == 1'b0)
                next_state = A;
            else
                next_state = B;
        end
        A: begin
            if (in == 1'b0)
                next_state = B;
            else
                next_state = A;
        end
    endcase
end

assign out = (state == A) ? 1'b1 : 1'b0;

endmodule
