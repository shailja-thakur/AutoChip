module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    reg [1:0] state, next_state;

    parameter S0 = 2'b00;
    parameter S1 = 2'b01;
    parameter S2 = 2'b10;

    always @(posedge clk or negedge aresetn) begin
        if (!aresetn)
            state <= S0;
        else
            state <= next_state;
    end

    always @(state or x) begin
        next_state = state;
        case (state)
            S0:
                if (x)
                    next_state = S1;
            S1:
                if (x)
                    next_state = S2;
            S2:
                if (!x)
                    next_state = S0;
        endcase
    end

    always @(state) begin
        case (state)
            S2:
                z <= 1'b1;
            default:
                z <= 1'b0;
        endcase
    end

endmodule
