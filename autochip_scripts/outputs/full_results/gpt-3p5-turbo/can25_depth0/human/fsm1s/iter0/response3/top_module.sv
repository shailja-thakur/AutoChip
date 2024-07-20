module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    reg [1:0] state;
    always @(posedge clk or posedge reset)
    begin
        if (reset)
            state <= 2'b10;  // Reset state B
        else
        begin
            case (state)
                2'b10:  // State B
                    if (in)
                        state <= 2'b10;  // Transition to state B
                    else
                        state <= 2'b01;  // Transition to state A
                    
                2'b01:  // State A
                    if (in)
                        state <= 2'b01;  // Transition to state A
                    else
                        state <= 2'b10;  // Transition to state B
            endcase
        end
    end

    assign out = (state == 2'b10) ? 1'b1 : 1'b0;

endmodule
