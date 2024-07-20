module top_module (
	input clk,
	input resetn,
	input [2:0] r,
	output [2:0] g
);

reg [1:0] state;
reg [1:0] next_state;

always @(posedge clk) begin
    if (!resetn)
        state <= 2'b00;
    else
        state <= next_state;
end

always @* begin
    case (state)
        2'b00: begin
            if (r[0])
                next_state = 2'b01;
            else if (r[1])
                next_state = 2'b10;
            else if (r[2])
                next_state = 2'b11;
            else
                next_state = 2'b00;
        end
        
        2'b01: begin
            if (r[0])
                next_state = 2'b01;
            else
                next_state = 2'b00;
        end
        
        2'b10: begin
            if (r[1])
                next_state = 2'b10;
            else
                next_state = 2'b00;
        end
        
        2'b11: begin
            if (r[2])
                next_state = 2'b11;
            else
                next_state = 2'b00;
        end
    endcase
end

assign g[0] = (state == 2'b01) ? 1'b1 : 1'b0;
assign g[1] = (state == 2'b10) ? 1'b1 : 1'b0;
assign g[2] = (state == 2'b11) ? 1'b1 : 1'b0;

endmodule
