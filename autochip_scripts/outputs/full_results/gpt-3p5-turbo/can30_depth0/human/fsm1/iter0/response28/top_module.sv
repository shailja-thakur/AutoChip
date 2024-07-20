module top_module (
    input clk,
    input in,
    input areset,
    output out
);

    reg [1:0] state;
    
    always @(posedge clk, posedge areset)
    begin
        if(areset)
            state <= 2'b01; // B state as default on reset
        else
        begin
            case(state)
                2'b00:   // A state
                    if(in)
                        state <= 2'b01; // Transition from A to B on input 1
                    else 
                        state <= 2'b00;
                2'b01:   // B state
                    if(in)
                        state <= 2'b01; // Stay in B state on input 1
                    else 
                        state <= 2'b00; // Transition from B to A on input 0
            endcase
        end
    end
    
    always @(state)
    begin
        case(state)
            2'b00: out <= 1'b0; // Output 0 in state A
            2'b01: out <= 1'b1; // Output 1 in state B
        endcase
    end

endmodule
