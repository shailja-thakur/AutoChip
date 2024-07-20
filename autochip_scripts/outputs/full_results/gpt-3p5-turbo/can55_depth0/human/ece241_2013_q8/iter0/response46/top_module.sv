module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state;
parameter S0 = 2'b00;
parameter S1 = 2'b01;
parameter S2 = 2'b10;

// Next state logic
always @(posedge clk or negedge aresetn) begin
    if (~aresetn)
        state <= S0; // Reset state
    else begin
        case (state)
            S0: if (x) state <= S1;
                else state <= S0;
            S1: if (!x) state <= S2;
                else if (x) state <= S1;
                else state <= S0;
            S2: if (x) state <= S1;
                else state <= S0;
        endcase
    end
end

// Output logic
always @(state, x) begin
    case (state)
        S1: if (x) z <= 1;
            else z <= 0;
        default: z <= 0;
    endcase
end

endmodule
