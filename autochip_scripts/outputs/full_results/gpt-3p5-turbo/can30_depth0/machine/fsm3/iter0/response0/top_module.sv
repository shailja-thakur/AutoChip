module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg [1:0] state;
reg out_reg;
reg [1:0] next_state;

always @(posedge clk or posedge areset)
begin
    if (areset)
        state <= 2'b00;
    else
        state <= next_state;
end

always @(state or in)
begin
    case (state)
        2'b00: begin
            if (in)
                next_state = 2'b01;
            else
                next_state = 2'b00;
        end
        2'b01: begin
            if (in)
                next_state = 2'b01;
            else
                next_state = 2'b10;
        end
        2'b10: begin
            if (in)
                next_state = 2'b11;
            else
                next_state = 2'b00;
        end
        2'b11: begin
            if (in)
                next_state = 2'b01;
            else
                next_state = 2'b10;
        end
        default: next_state = 2'b00;
    endcase
end

assign out = (state == 2'b11);

endmodule
