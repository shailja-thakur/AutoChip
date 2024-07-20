module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [2:0] state;

parameter S0 = 0;
parameter S1 = 1;
parameter S2 = 2;

always @(posedge clk or negedge aresetn) begin
    if (!aresetn)
        state <= S0;
    else begin
        case (state)
            S0: begin
                if (x)
                    state <= S1;
                else
                    state <= S0;
            end
            S1: begin
                if (x)
                    state <= S1;
                else
                    state <= S2;
            end
            S2: begin
                if (x)
                    state <= S0;
                else
                    state <= S2;
            end
        endcase
    end
end

always @(posedge clk) begin
    if (state == S2)
        z <= 1'b1;
    else
        z <= 1'b0;
end

endmodule
