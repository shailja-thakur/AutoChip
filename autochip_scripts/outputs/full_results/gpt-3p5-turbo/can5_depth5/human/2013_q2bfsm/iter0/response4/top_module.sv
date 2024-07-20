module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

    reg f_reg, g_reg;
    reg [2:0] state, next_state;
    
    always @(posedge clk or negedge resetn) begin
        if(!resetn) begin
            state <= 3'b000;
            f_reg <= 1'b0;
            g_reg <= 1'b0;
        end else begin
            state <= next_state;
            f_reg <= state == 3'b001 ? 1'b1 : 1'b0;
            case(state)
                3'b000: if(x == 1'b1) next_state = 3'b001; else next_state = 3'b000;
                3'b001: if(x == 1'b0) next_state = 3'b010; else next_state = 3'b001;
                3'b010: if(x == 1'b1) next_state = 3'b011; else next_state = 3'b010;
                3'b011: if(y == 1'b0) next_state = 3'b100; else next_state = 3'b101;
                3'b100: if(resetn == 1'b0) next_state = 3'b000; else next_state = 3'b100;
                3'b101: if(y == 1'b0) next_state = 3'b110; else next_state = 3'b111;
                3'b110: if(y == 1'b0) next_state = 3'b100; else next_state = 3'b101;
                3'b111: if(resetn == 1'b0) next_state = 3'b000; else next_state = 3'b111;
            endcase
        end
    end

    assign f = f_reg;
    assign g = g_reg;

endmodule
