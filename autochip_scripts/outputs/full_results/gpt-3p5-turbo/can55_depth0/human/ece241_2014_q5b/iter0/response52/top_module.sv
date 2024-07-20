module top_module (
	input clk,
	input areset,
	input x,
	output z
);
    reg [1:0] state, next_state;
   
    always @ (posedge clk or posedge areset) begin
        if (areset)
            state <= 2'b00;
        else
            state <= next_state;
    end
    
    always @ (state or x) begin
        case (state)
            2'b00:
                if (x == 1'b0)
                    next_state = 2'b00;  // stay in state A
                else
                    next_state = 2'b01;  // transition to state B
            2'b01:
                if (x == 1'b0)
                    next_state = 2'b01;  // stay in state B
                else
                    next_state = 2'b10;  // transition to state B
            default:
                next_state = 2'b10;      // stay in state B
        endcase
    end
    
    always @ (state) begin
        case (state)
            2'b00: z = 1'b0;
            2'b01: z = 1'b1;
            default: z = 1'b0;
        endcase
    end
endmodule
