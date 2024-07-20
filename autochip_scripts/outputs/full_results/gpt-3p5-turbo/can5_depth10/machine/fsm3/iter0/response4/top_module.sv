module top_module (
    input clk,
    input in,
    input areset,
    output out
);
    
    reg [1:0] state, next_state;
    
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= 2'b00; // reset to state A
        else
            state <= next_state;
    end
    
    always @(state or in) begin
        case (state)
            2'b00: // A
                if (in)
                    next_state = 2'b01; // B
                else
                    next_state = 2'b00; // A
            2'b01: // B
                if (in)
                    next_state = 2'b01; // B
                else
                    next_state = 2'b10; // C
            2'b10: // C
                if (in)
                    next_state = 2'b11; // D
                else
                    next_state = 2'b00; // A
            2'b11: // D
                if (in)
                    next_state = 2'b01; // B
                else
                    next_state = 2'b10; // C
        endcase
    end
    
    assign out = (state == 2'b11) ? 1'b1 : 1'b0;
    
endmodule
