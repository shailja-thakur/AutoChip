module top_module (
	input clk,
	input in,
	input reset,
	output out
);

    reg [1:0] state;
    reg [1:0] next_state;
    reg out_reg;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= 2'b00;
            out_reg <= 1'b0;
        end
        else begin
            state <= next_state;
            out_reg <= (state == 2'b10) ? 1'b1 : 1'b0;
        end
    end

    always @* begin
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
                    next_state = 2'b01;
            end
            2'b11: begin
                if (in)
                    next_state = 2'b01;
                else
                    next_state = 2'b10;
            end
        endcase
    end

    assign out = out_reg;

endmodule
