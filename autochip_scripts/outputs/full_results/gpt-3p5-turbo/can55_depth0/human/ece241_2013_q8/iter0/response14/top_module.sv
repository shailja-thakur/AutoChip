module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [2:0] state;
parameter S0 = 3'd0;
parameter S1 = 3'd1;
parameter S2 = 3'd2;

always @(posedge clk or negedge aresetn) begin
    if (~aresetn) begin
        state <= S0;
        z <= 0;
    end else begin
        case (state)
            S0: begin
                if (x) begin
                    state <= S1;
                end else begin
                    state <= S0;
                end
            end
            S1: begin
                if (x) begin
                    state <= S1;
                end else begin
                    state <= S2;
                end
            end
            S2: begin
                if (x) begin
                    state <= S0;
                    z <= 1;
                end else begin
                    state <= S2;
                end
            end
            default: state <= S0;
        endcase
    end
end

endmodule
