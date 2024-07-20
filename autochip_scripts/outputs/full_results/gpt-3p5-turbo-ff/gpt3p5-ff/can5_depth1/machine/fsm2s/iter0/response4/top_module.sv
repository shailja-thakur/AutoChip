module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output out
);

    reg [1:0] state;
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 2'b00; // Initialize state to A
        else begin
            case (state)
                2'b00: // State A
                    if (j)
                        state <= 2'b01; // Transition to state B when j is high
                    else
                        state <= 2'b00; // Stay in state A when j is low
                    
                2'b01: // State B
                    if (k)
                        state <= 2'b00; // Transition to state A when k is high
                    else
                        state <= 2'b01; // Stay in state B when k is low
            endcase
        end
    end
    
    assign out = (state == 2'b01) ? 1'b1 : 1'b0; // Output is high when state is B, low when state is A
    
endmodule
