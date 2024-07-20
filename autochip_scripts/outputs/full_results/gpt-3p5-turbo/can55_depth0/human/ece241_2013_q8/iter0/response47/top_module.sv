module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [2:0] state, next_state;

parameter S0 = 3'b000;
parameter S1 = 3'b001;
parameter S2 = 3'b010;

// State transition and output logic
always @(posedge clk or negedge aresetn)
    if (~aresetn)
        state <= S0;
    else
        state <= next_state;

always @(state or x)
    case (state)
        S0:
            if (x == 1'b1)
                next_state = S1;
            else
                next_state = S0;
        S1:
            if (x == 1'b0)
                next_state = S2;
            else
                next_state = S0;
        S2:
            if (x == 1'b1)
                begin
                    next_state = S1;
                    z = 1'b1;
                end
            else
                next_state = S0;
    endcase

endmodule
