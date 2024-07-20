module top_module (
	input clk,
	input areset,
	input x,
	output z
);

reg [1:0] state, next_state;
parameter [1:0] A = 2'b00;
parameter [1:0] B = 2'b01;

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= A;
    else
        state <= next_state;
end

always @* begin
    case (state)
        A: begin
            if (x)
                next_state = B;
            else
                next_state = A;
            z = x;
        end
        B: begin
            if (x)
                next_state = B;
            else
                next_state = B;
            z = ~x;
        end
        default: begin
            next_state = A;
            z = 1'b0;
        end
    endcase
end

endmodule
