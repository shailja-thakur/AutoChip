module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    // Define states
    parameter OFF = 0;
    parameter ON = 1;

    // Internal state register
    reg [1:0] state;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= OFF; // Reset to OFF state
        end else begin
            case (state)
                OFF: begin
                    if (j)
                        state <= ON; // Transition to ON state if j is high
                    else
                        state <= OFF; // Stay in OFF state if j is low
                end
                ON: begin
                    if (k)
                        state <= OFF; // Transition to OFF state if k is high
                    else
                        state <= ON; // Stay in ON state if k is low
                end
            endcase
        end
    end
    
    always @(state) begin
        case (state)
            OFF: out = 0;
            ON: out = 1;
        endcase
    end
    
endmodule
