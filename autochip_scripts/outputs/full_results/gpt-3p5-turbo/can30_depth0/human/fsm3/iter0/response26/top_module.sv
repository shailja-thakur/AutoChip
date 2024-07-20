module top_module (
    input clk,
    input in,
    input areset,
    output out
);

    reg [1:0] state;
    reg out_reg;

    always @(posedge clk or posedge areset)
    begin
        if (areset)
            state <= 2'b00; // Reset state to A
        else
        begin
            case (state)
                2'b00:
                    begin
                        if (in)
                            state <= 2'b01; // Transition to B on input 1
                    end
                2'b01:
                    begin
                        if (in)
                            state <= 2'b01; // Stay in B on input 1
                        else
                            state <= 2'b10; // Transition to C on input 0
                    end
                2'b10:
                    begin
                        if (in)
                            state <= 2'b11; // Transition to D on input 1
                        else
                            state <= 2'b00; // Transition to A on input 0
                    end
                2'b11:
                    begin
                        if (in)
                            state <= 2'b10; // Transition to C on input 1
                        else
                            state <= 2'b01; // Transition to B on input 0
                    end
                default:
                    state <= 2'b00; // Default to A state
            endcase
        end
    end
    
    always @(state)
    begin
        case (state)
            2'b00:
                out_reg = 1'b0;
            2'b01, 2'b11:
                out_reg = 1'b0;
            2'b10:
                out_reg = 1'b1;
            default:
                out_reg = 1'b0;
        endcase
    end
    
    assign out = out_reg;

endmodule
