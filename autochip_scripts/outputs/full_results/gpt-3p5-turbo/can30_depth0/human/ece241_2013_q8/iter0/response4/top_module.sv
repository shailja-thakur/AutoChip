module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state;
parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10;

always @(negedge aresetn or posedge clk) begin
    if (~aresetn)
        state <= S0;
    else begin
        case (state)
            S0: begin
                if (x == 1'b1)
                    state <= S1;
                else
                    state <= S0;
            end
            S1: begin
                if (x == 1'b0)
                    state <= S0;
                else
                    state <= S2;
            end
            S2: begin
                if (x == 1'b1)
                    state <= S1;
                else
                    state <= S0;
            end
        endcase
    end
end

always @(state, x)begin
    if (state == S1 && x == 1'b1)
        z <= 1'b1;
    else
        z <= 1'b0;
end

endmodule
