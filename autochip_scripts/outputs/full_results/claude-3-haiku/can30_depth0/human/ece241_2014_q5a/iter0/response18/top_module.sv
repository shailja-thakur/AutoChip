module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

reg [7:0] accumulator;
reg [2:0] state;

localparam [2:0] 
    S_RESET = 3'd0,
    S_ACCEPT = 3'd1,
    S_COMPLEMENT = 3'd2,
    S_OUTPUT = 3'd3;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= S_RESET;
        accumulator <= 8'd0;
        z <= 1'b0;
    end
    else begin
        case (state)
            S_RESET: begin
                state <= S_ACCEPT;
            end
            S_ACCEPT: begin
                accumulator <= {accumulator[6:0], x};
                if (areset) begin
                    state <= S_RESET;
                end
                else begin
                    state <= S_COMPLEMENT;
                end
            end
            S_COMPLEMENT: begin
                accumulator <= ~accumulator + 1'b1;
                state <= S_OUTPUT;
            end
            S_OUTPUT: begin
                z <= accumulator[0];
                accumulator <= {1'b0, accumulator[7:1]};
                if (accumulator == 8'b0) begin
                    state <= S_RESET;
                end
                else begin
                    state <= S_OUTPUT;
                end
            end
        endcase
    end
end

endmodule
