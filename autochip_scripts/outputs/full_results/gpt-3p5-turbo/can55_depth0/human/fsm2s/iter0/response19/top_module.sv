module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);
    
    // State enumeration
    parameter OFF = 0, ON = 1;
    
    // State register
    reg [1:0] state;
    
    // Next state logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= OFF;
        else begin
            case (state)
                OFF: if (j) state <= ON; else state <= OFF;
                ON: if (k) state <= OFF; else state <= ON;
                default: state <= OFF;
            endcase
        end
    end
    
    // Output logic
    always @(state) begin
        case (state)
            OFF: out <= 0;
            ON: out <= 1;
            default: out <= 0;
        endcase
    end
    
endmodule
