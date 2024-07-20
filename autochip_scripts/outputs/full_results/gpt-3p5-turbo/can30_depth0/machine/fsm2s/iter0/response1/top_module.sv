module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output out
);
    reg [1:0] state;
    
    always @(posedge clk or posedge reset)
    begin
        if (reset)
            state <= 2'b00; // Initialize state to A
        else
        begin
            case (state)
                2'b00: // State A
                    state <= (j) ? 2'b01 : 2'b00; // Transition to B if j is high, otherwise stay in A
                2'b01: // State B
                    state <= (k) ? 2'b00 : 2'b01; // Transition to A if k is high, otherwise stay in B
                default:
                    state <= 2'b00; // Default to state A
            endcase
        end
    end
    
    assign out = (state == 2'b01) ? 1'b1 : 1'b0; // Output is high when state is B, otherwise low
    
endmodule
