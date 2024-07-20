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
            state <= 2'b00; // Reset to state A
        else
        begin
            case(state)
                2'b00: // State A
                    begin
                        if (in)
                            state <= 2'b01; // Next state is B
                        else
                            state <= 2'b00; // Next state is A
                    end
                2'b01: // State B
                    begin
                        if (in)
                            state <= 2'b01; // Next state is B
                        else
                            state <= 2'b10; // Next state is C
                    end
                2'b10: // State C
                    begin
                        if (in)
                            state <= 2'b11; // Next state is D
                        else
                            state <= 2'b00; // Next state is A
                    end
                2'b11: // State D
                    begin
                        if (in)
                            state <= 2'b01; // Next state is B
                        else
                            state <= 2'b10; // Next state is C
                    end
            endcase
        end
    end
    
    always @(state)
    begin
        case(state)
            2'b00: // State A
                out_reg = 1'b0;
            2'b01: // State B
                out_reg = 1'b0;
            2'b10: // State C
                out_reg = 1'b0;
            2'b11: // State D
                out_reg = 1'b1;
        endcase
    end
    
    assign out = out_reg;
    
endmodule
