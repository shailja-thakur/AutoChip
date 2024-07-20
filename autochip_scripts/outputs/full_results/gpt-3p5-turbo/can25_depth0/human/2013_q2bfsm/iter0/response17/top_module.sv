module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
); 

reg [1:0] state_reg, state_next;
reg f_reg, f_next;
reg g_reg, g_next;

always @(posedge clk or negedge resetn) begin
	if (~resetn) begin
		state_reg <= 2'b00; // state A
		f_reg <= 1'b0;
		g_reg <= 1'b0;
	end else begin
		state_reg <= state_next;
		f_reg <= f_next;
		g_reg <= g_next;
	end
end

always @(state_reg or x or y) begin
	case(state_reg)
		2'b00: begin // state A
			if (~resetn) begin
				f_next = 1'b0;
				g_next = 1'b0;
				state_next = 2'b00;
			end else if (x) begin
				state_next = 2'b01; // state B
			end else begin
				state_next = 2'b00; // remain in state A
			end
		end
		2'b01: begin // state B
            f_next = 1'b1;
            g_next = 1'b0;
            if (x) begin
                state_next = 2'b10; // state C
            end else begin
                state_next = 2'b01; // remain in state B
            end
		end
        2'b10: begin // state C
            f_next = 1'b0;
            if (x) begin
                state_next = 2'b11; // state D
            end else begin
                state_next = 2'b10; // remain in state C
            end
        end
        2'b11: begin // state D
            if (x) begin
                if (y) begin
                    g_next = 1'b1;
                    state_next = 2'b11; // remain in state D
                end else begin
                    g_next = 1'b0;
                    state_next = 2'b00; // state A
                end
            end else begin
                g_next = 1'b0;
                state_next = 2'b11; // remain in state D
            end
        end
	endcase
end

assign f = f_reg;
assign g = g_reg;

endmodule
