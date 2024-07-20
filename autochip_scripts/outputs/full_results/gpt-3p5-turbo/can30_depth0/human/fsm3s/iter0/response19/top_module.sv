module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    reg [1:0] state;
    reg out_reg;

    always @(posedge clk) begin
        if (reset)
            state <= 2'b00; // reset to state A
        else begin
            case (state)
                2'b00: if (in) state <= 2'b01; else state <= 2'b00; // next state A or B
                2'b01: if (in) state <= 2'b01; else state <= 2'b10; // next state B or C
                2'b10: if (in) state <= 2'b11; else state <= 2'b00; // next state A or D
                2'b11: if (in) state <= 2'b01; else state <= 2'b10; // next state B or C
            endcase
        end
    end

    always @(state) begin
        case (state)
            2'b00: out_reg = 1'b0; // output 0 in state A
            2'b01: out_reg = 1'b0; // output 0 in state B
            2'b10: out_reg = 1'b0; // output 0 in state C
            2'b11: out_reg = 1'b1; // output 1 in state D
        endcase
    end

    assign out = out_reg;

endmodule
