module top_module (
	input in,
	input [1:0] state,
	output reg [1:0] next_state,
	output reg out
);

always @(*) begin
    case(state)
        2'b00: begin
            if(in)
                next_state = 2'b01;  // Next state B
            else
                next_state = 2'b00;  // Next state A
            out = 1'b0;  // Output 0
        end
        
        2'b01: begin
            if(in)
                next_state = 2'b01;  // Next state B
            else
                next_state = 2'b10;  // Next state C
            out = 1'b0;  // Output 0
        end
        
        2'b10: begin
            if(in)
                next_state = 2'b11;  // Next state D
            else
                next_state = 2'b00;  // Next state A
            out = 1'b0;  // Output 0
        end
        
        2'b11: begin
            if(in)
                next_state = 2'b01;  // Next state B
            else
                next_state = 2'b10;  // Next state C
            out = 1'b1;  // Output 1
        end
    endcase
end

endmodule
