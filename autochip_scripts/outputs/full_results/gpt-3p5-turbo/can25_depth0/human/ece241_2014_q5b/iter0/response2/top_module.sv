module top_module (
	input clk,
	input areset,
	input x,
	output z
);

reg [1:0] state;
reg z_reg;
reg z_next;

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= 2'b00;
    else begin
        case(state)
            2'b00: begin
                if (x)
                    state <= 2'b01;
                else
                    state <= 2'b00;
            end
            2'b01: begin
                if (x)
                    state <= 2'b01;
                else
                    state <= 2'b10;
            end
            2'b10: begin
                if (x)
                    state <= 2'b10;
                else
                    state <= 2'b10;
            end
        endcase
    end
end

always @(state) begin
    case(state)
        2'b00: begin
            z_next = 1'b0;
        end
        2'b01, 2'b10: begin
            z_next = 1'b1;
        end
    endcase
end

always @(posedge clk) begin
    z_reg <= z_next;
end

assign z = z_reg;

endmodule
