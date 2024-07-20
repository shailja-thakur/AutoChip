module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    // State definitions
    parameter OFF = 0;
    parameter ON = 1;
    
    // State register
    reg [1:0] current_state;
    
    // Next state logic
    always @(posedge clk or posedge reset)
    begin
        if (reset)
            current_state <= OFF;
        else
        begin
            case(current_state)
                OFF:
                    if (j)
                        current_state <= ON;
                    else
                        current_state <= OFF;
                ON:
                    if (k)
                        current_state <= OFF;
                    else
                        current_state <= ON;
                default:
                    current_state <= OFF;
            endcase
        end
    end
    
    // Output logic
    always @(current_state)
    begin
        case(current_state)
            OFF:
                out <= 0;
            ON:
                out <= 1;
            default:
                out <= 0;
        endcase
    end

endmodule
