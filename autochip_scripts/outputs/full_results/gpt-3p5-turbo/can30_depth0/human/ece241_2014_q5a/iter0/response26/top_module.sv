module top_module (
	input clk,
	input areset,
	input x,
	output z
);

reg [1:0] state;
reg z;
reg next_state;

always @(posedge clk or negedge areset)
begin
    if (areset == 0)
        state <= 2'b00;
    else
        state <= next_state;
end

always @*
begin
    case (state)
        2'b00: begin
            if (areset == 0)
                next_state = 2'b00;
            else if (x == 1)
                next_state = 2'b01;
            else
                next_state = 2'b00;
        end
        2'b01: begin
            if (areset == 0)
                next_state = 2'b00;
            else if (x == 1)
                next_state = 2'b01;
            else
                next_state = 2'b10;
        end
        2'b10: begin
            if (areset == 0)
                next_state = 2'b00;
            else if (x == 1)
                next_state = 2'b11;
            else
                next_state = 2'b10;
        end
        2'b11: begin
            if (areset == 0)
                next_state = 2'b00;
            else if (x == 1)
                next_state = 2'b11;
            else
                next_state = 2'b00;
        end
    endcase
end

always @(posedge clk or negedge areset)
begin
    if (areset == 0)
        z <= 0;
    else if (state == 2'b10)
        z <= ~x;
    else
        z <= z;
end

endmodule
