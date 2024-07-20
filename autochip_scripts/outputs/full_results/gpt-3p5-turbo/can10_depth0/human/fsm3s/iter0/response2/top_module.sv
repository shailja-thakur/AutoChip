module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    reg [1:0] state;
    reg out_reg;
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 2'b00; // State A is represented as 2'b00
        else begin
            case(state)
                2'b00: // State A
                    if (in)
                        state <= 2'b01; // Next state in=1 is represented as 2'b01 (State B)
                    else
                        state <= 2'b00; // Next state in=0 is represented as 2'b00 (State A)
                2'b01: // State B
                    if (in)
                        state <= 2'b01; // Next state in=1 is represented as 2'b01 (Stay in State B)
                    else
                        state <= 2'b10; // Next state in=0 is represented as 2'b10 (State C)
                2'b10: // State C
                    if (in)
                        state <= 2'b00; // Next state in=1 is represented as 2'b00 (State A)
                    else
                        state <= 2'b11; // Next state in=0 is represented as 2'b11 (State D)
                2'b11: // State D
                    if (in)
                        state <= 2'b10; // Next state in=1 is represented as 2'b10 (State C)
                    else
                        state <= 2'b00; // Next state in=0 is represented as 2'b00 (State A)
            endcase
        end
    end
    
    always @(posedge clk) begin
        case(state)
            2'b00: // State A
                out_reg <= 1'b0; // output in state A is 0
            2'b01: // State B
                out_reg <= 1'b0; // output in state B is 0
            2'b10: // State C
                out_reg <= 1'b0; // output in state C is 0
            2'b11: // State D
                out_reg <= 1'b1; // output in state D is 1
        endcase
    end
    
    assign out = out_reg;

endmodule
