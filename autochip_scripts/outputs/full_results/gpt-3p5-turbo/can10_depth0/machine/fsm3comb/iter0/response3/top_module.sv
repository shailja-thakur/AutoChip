module top_module (
	input in,
	input [1:0] state,
	output reg [1:0] next_state,
	output out
);
    always @(*) begin
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
        endcase
    end
    
    assign out = (state == 2'b11) ? 1'b1 : 1'b0;
endmodule
