module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    // State declaration
    reg [1:0] state;
    
    // State assignments
    parameter OFF = 2'b00;
    parameter ON = 2'b01;
    
    // Next state logic
    always @(posedge clk or posedge areset)
    begin
        if (areset)
            state <= OFF; // Reset state to OFF
        else
        begin
            case (state)
                OFF: state <= (j) ? ON : OFF;
                ON: state <= (k) ? OFF : ON;
            endcase
        end
    end
    
    // Output logic
    always @(state)
    begin
        case (state)
            OFF: out <= 0;
            ON: out <= 1;
        endcase
    end

endmodule
