module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output out
);

    reg [1:0] state, next_state;

    always @(*) begin
        case(state)
            0: // state A
                if(j)
                    next_state = 1; // state B
                else
                    next_state = 0; // state A
            1: // state B
                if(k)
                    next_state = 0; // state A
                else
                    next_state = 1; // state B
        endcase
    end

    always @(posedge clk) begin
        if(areset)
            state <= 0; // state A
        else
            state <= next_state;
    end

    assign out = (state == 1) ? 1'b1 : 1'b0;

endmodule
