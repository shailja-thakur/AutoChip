module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

reg [3:0] state;
reg [7:0] in_reg;
reg [7:0] in_reg_prev;

always @(posedge clk or posedge reset) begin
    if(reset) begin
        state <= 0;
        done <= 0;
        in_reg <= 0;
        in_reg_prev <= 0;
    end else begin
        in_reg <= in; // Capture input value
        
        // Check if transition to state 1 should happen
        if (state == 0 && in_reg[3] == 1 && in_reg_prev[3] == 0)
            state <= 1;
        
        // Check if transition to state 2 should happen
        else if (state == 1 && in_reg[3] == 1 && in_reg_prev[3] == 0)
            state <= 2;
        
        // Check if transition to state 0 should happen
        else if (state == 2 && in_reg[3] == 1)
            state <= 0;
        
        // Check if transition to done state should happen
        if (state == 2 && in_reg[3] == 1 && in_reg_prev[3] == 1)
            done <= 1;
        
        // Save current input value for next cycle
        in_reg_prev <= in_reg;
    end
end

endmodule
