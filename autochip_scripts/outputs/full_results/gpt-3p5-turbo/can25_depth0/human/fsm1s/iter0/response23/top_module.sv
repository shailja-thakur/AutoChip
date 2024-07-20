module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    reg [1:0] state;
    
    always @(posedge clk) begin
        if (reset)
            state <= 2'b10; // reset state is B
        else begin
            case (state)
                2'b01: begin // A state
                    if (in)
                        state <= 2'b01; // stay in A
                    else
                        state <= 2'b10; // transition to B
                end
                2'b10: begin // B state
                    if (in)
                        state <= 2'b10; // stay in B
                    else
                        state <= 2'b01; // transition to A
                end
            endcase
        end
    end
    
    always @(state) begin
        case (state)
            2'b01: out = 1; // output is 1 when in state A
            2'b10: out = 0; // output is 0 when in state B
        endcase
    end
    
endmodule
