module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

reg [1:0] state, next_state;

always @(posedge clk or negedge resetn) begin
    if (!resetn)
        state <= 2'b00;
    else
        state <= next_state;
end

always @(state or x) begin
    case(state)
        2'b00: begin // State A
            if (x)
                next_state = 2'b01;
            else
                next_state = 2'b00;
        end
        2'b01: begin // State B
            if (x)
                next_state = 2'b10;
            else
                next_state = 2'b01;
        end
        2'b10: begin // State C
            if (x)
                next_state = 2'b11;
            else
                next_state = 2'b10;
        end
        2'b11: begin // State D
            if (x)
                next_state = 2'b00;
            else
                next_state = 2'b11;
        end
        default: next_state = 2'b00;
    endcase
end

reg f_reg, g_reg;

always @(posedge clk or negedge resetn) begin
    if (!resetn)
        f_reg <= 1'b0;
    else begin
        case(state)
            2'b00: f_reg <= 1'b0; // State A
            2'b11: f_reg <= 1'b1; // State D
            default: f_reg <= 1'b0;
        endcase
    end
end

always @(posedge clk or negedge resetn) begin
    if (!resetn)
        g_reg <= 1'b0;
    else begin
        case(state)
            2'b00, 2'b01, 2'b10: g_reg <= 1'b0; // State A, B, C
            2'b11: begin // State D
                if (y)
                    g_reg <= 1'b1;
                else
                    g_reg <= 1'b0;
            end
            default: g_reg <= 1'b0;
        endcase
    end
end

assign f = f_reg;
assign g = g_reg;

endmodule
