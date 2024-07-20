module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);
    reg [1:0] state;
    
    always @(posedge clk or negedge reset) begin
        if (!reset)
            state <= 2'b00; // Initializing state to A
        else begin
            case (state)
                2'b00: // State A
                    if (j)
                        state <= 2'b01; // Transition to state B if j is high
                    else
                        state <= 2'b00; // Remain in state A if j is low
                2'b01: // State B
                    if (k)
                        state <= 2'b00; // Transition to state A if k is high
                    else
                        state <= 2'b01; // Remain in state B if k is low
            endcase
        end
    end
    
    always @(state) begin
        out <= (state == 2'b01) ? 1'b1 : 1'b0; // Output out is high when state is B, and low when state is A
    end
endmodule
