module top_module (
    input clk,
    input in,
    input areset,
    output out
);
    reg [1:0] state;
    reg out_reg;
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= 2'b01; // state B
        else begin
            case(state)
                2'b00: // state A
                    if (in)
                        state <= 2'b00; // stay in state A
                    else
                        state <= 2'b01; // transition to state B
                2'b01: // state B
                    if (in)
                        state <= 2'b01; // stay in state B
                    else
                        state <= 2'b00; // transition to state A
            endcase
        end
    end

    always @(state) begin
        if (state == 2'b00) // state A
            out_reg <= 1'b0;
        else // state B
            out_reg <= 1'b1;
    end

    assign out = out_reg;
endmodule
