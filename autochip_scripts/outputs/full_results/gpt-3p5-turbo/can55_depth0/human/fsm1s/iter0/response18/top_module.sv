module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    reg [1:0] state;
    reg out;

    always @(posedge clk, posedge reset)
    begin
        if (reset)
            state <= 2'b01; // reset to state B
        else
            case (state)
                2'b00: begin // state A
                    if (in)
                        state <= 2'b01; // in=1, transition to state A
                    else
                        state <= 2'b00; // in=0, stay in state A
                end
                2'b01: begin // state B
                    if (in)
                        state <= 2'b01; // in=1, stay in state B
                    else
                        state <= 2'b00; // in=0, transition to state B
                end
                default: state <= 2'b01; // default to state B
            endcase
    end

    always @(state)
    begin
        case (state)
            2'b00: out = 1'b0; // state A
            2'b01: out = 1'b1; // state B
            default: out = 1'b1; // default to out=1 for undefined states
        endcase
    end

endmodule
