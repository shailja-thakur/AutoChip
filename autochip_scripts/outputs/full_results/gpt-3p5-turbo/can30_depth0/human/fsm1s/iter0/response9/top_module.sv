module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    reg out_reg;
    reg [1:0] state;

    always @(posedge clk) begin
        if (reset)
            state <= 2'b10;  // The reset state B
        else begin
            case (state)
                2'b10: begin  // State B
                    if (in == 1)
                        state <= 2'b10;  // Stay in state B
                    else
                        state <= 2'b01;  // Transition to state A
                end
                2'b01: begin  // State A
                    if (in == 0)
                        state <= 2'b10;  // Transition to state B
                    else
                        state <= 2'b01;  // Stay in state A
                end
            endcase
        end
    end

    always @(state) begin
        case (state)
            2'b10: out_reg = 1;  // Output 1 in state B
            2'b01: out_reg = 0;  // Output 0 in state A
        endcase
    end

    assign out = out_reg;

endmodule
