module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output out
);

    reg [1:0] state;
    
    always @(posedge clk, posedge reset) begin
        if (reset)
            state <= 2'b00;   // Initialize to state OFF
        else
            case(state)
                2'b00: begin   // OFF
                    if (j)
                        state <= 2'b01;   // Transition to state ON
                    else
                        state <= 2'b00;   // Remain in state OFF
                end
                2'b01: begin   // ON
                    if (k)
                        state <= 2'b00;   // Transition to state OFF
                    else
                        state <= 2'b01;   // Remain in state ON
                end
            endcase
    end
    
    assign out = state[1];
    
endmodule
