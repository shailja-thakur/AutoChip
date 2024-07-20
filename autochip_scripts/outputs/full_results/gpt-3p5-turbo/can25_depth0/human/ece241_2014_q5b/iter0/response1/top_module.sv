module top_module (
    input clk,
    input areset,
    input x,
    output z
);

    reg [1:0] state, next_state;
    
    always @(posedge clk, posedge areset) begin
        if (areset)
            state <= 2'b00;  // Reset state to A
        else
            state <= next_state; // Update state based on next_state value
    end
    
    always @(*) begin
        case (state)
            2'b00: begin  // State A
                if (x == 1'b0) begin
                    next_state = 2'b00;  // Stay in state A
                    z = 1'b0;
                end
                else begin
                    next_state = 2'b01;  // Go to state B
                    z = 1'b1;
                end
            end
            
            2'b01: begin  // State B
                if (x == 1'b0) begin
                    next_state = 2'b01;  // Stay in state B
                    z = 1'b1;
                end
                else begin
                    next_state = 2'b01;  // Stay in state B
                    z = 1'b0;
                end
            end
        endcase
    end
endmodule
