module top_module(
    input clk,
    input reset,
    input data,
    output start_shifting);
    
    reg [3:0] state;
    always @(posedge clk or posedge reset)
    begin
        if (reset)
            state <= 4'b0000; // Initializing to state S
        else
        begin
            case(state)
                4'b0000: // State S
                    if (data)
                        state <= 4'b0001; // Transition to state S1
                    else
                        state <= 4'b0000; // Remain in state S
                4'b0001: // State S1
                    if (data)
                        state <= 4'b0011; // Transition to state S11
                    else
                        state <= 4'b0000; // Transition to state S
                4'b0011: // State S11
                    if (data)
                        state <= 4'b0011; // Remain in state S11
                    else
                        state <= 4'b0110; // Transition to state S110
                4'b0110: // State S110
                    if (data)
                        state <= 4'b1111; // Transition to state Done
                    else
                        state <= 4'b0000; // Transition to state S
                4'b1111: // State Done
                    state <= 4'b1111; // Remain in state Done
                default: // Should never happen
                    state <= 4'b0000; // Reset to state S
            endcase
        end
    end
    
    assign start_shifting = (state == 4'b1111) ? 1'b1 : 1'b0; // Output high if state is Done, else low
    
endmodule
