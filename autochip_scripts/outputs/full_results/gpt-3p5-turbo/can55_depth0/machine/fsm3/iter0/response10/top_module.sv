module top_module (
    input clk,
    input in,
    input areset,
    output out
);

    reg [1:0] state;
    
    always @(posedge clk or posedge areset)
    begin
        if (areset)
            state <= 2'b00; // reset to state A
        else
        begin
            case (state)
                2'b00: state <= (in) ? 2'b01 : 2'b00; // if state A, next state is B if in = 1 else A
                2'b01: state <= (in) ? 2'b01 : 2'b10; // if state B, next state is B if in = 1 else C
                2'b10: state <= (in) ? 2'b11 : 2'b00; // if state C, next state is D if in = 1 else A
                2'b11: state <= (in) ? 2'b01 : 2'b10; // if state D, next state is B if in = 1 else C
            endcase
        end
    end
    
    assign out = (state == 2'b11) ? 1'b1 : 1'b0;
    
endmodule
