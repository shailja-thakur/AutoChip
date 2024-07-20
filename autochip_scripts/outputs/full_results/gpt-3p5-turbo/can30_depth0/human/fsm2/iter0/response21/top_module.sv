module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    // Define the states
    parameter OFF = 0;
    parameter ON = 1;
    
    // Define the state and output registers
    reg [1:0] state;
    
    // Synchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= OFF;
        else begin
            case (state)
                OFF: begin
                    if (j)
                        state <= ON;
                    else
                        state <= OFF;
                end
                ON: begin
                    if (k)
                        state <= OFF;
                    else
                        state <= ON;
                end
                default: state <= OFF;
            endcase
        end
    end
    
    // Assign output based on the current state
    always @(state) begin
        case (state)
            OFF: out = 0;
            ON: out = 1;
            default: out = 0;
        endcase
    end

endmodule
