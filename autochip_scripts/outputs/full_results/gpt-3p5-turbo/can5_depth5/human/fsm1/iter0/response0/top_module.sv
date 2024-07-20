module top_module (
    input clk,
    input in,
    input areset,
    output out
);

    reg [1:0] state;
    
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= 2'b01; // Reset to state B
        else begin
            case(state)
                2'b00: begin // State B
                    if (in)
                        state <= 2'b00; // Stays in state B
                    else
                        state <= 2'b01; // Transition to state A
                end
                
                2'b01: begin // State A
                    if (in)
                        state <= 2'b01; // Stays in state A
                    else
                        state <= 2'b00; // Transition to state B
                end
            endcase
        end
    end
    
    assign out = state[0];
    
endmodule
