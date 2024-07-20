module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

localparam S0 = 2'b00;
localparam S1 = 2'b01;
localparam S2 = 2'b10;

reg [1:0] state, next_state;

// State transition logic
always @(*) begin
    case (state)
        S0: next_state = (x == 0) ? S0 : S1;
        S1: next_state = (x == 1) ? S2 : S0;
        S2: next_state = (x == 0) ? S0 : S1;
        default: next_state = S0;
    endcase
end

// Output logic
always @(*) begin
    case (state)
        S2: z = 1'b1;
        default: z = 1'b0;
    endcase
end

// State registers
always @(posedge clk, negedge aresetn) begin
    if (!aresetn)
        state <= S0;
    else
        state <= next_state;
end

endmodule
