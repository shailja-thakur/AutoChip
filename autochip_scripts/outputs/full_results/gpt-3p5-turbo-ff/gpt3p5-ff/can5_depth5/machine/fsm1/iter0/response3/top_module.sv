module top_module (
    input clk,
    input in,
    input areset,
    output out
);

reg state;   // define a register to store the state

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 1'b0;   // reset the state to B when areset is high
    end else begin
        if (state) begin
            if (in) begin
                state <= 1'b1;   // if state is B and input is high, stay at B
            end else begin
                state <= 1'b0;   // if state is B and input is low, move to A
            end
        end else begin
            if (in) begin
                state <= 1'b0;   // if state is A and input is high, stay at A
            end else begin
                state <= 1'b1;   // if state is A and input is low, move to B
            end
        end
    end
end

assign out = state;   // output is high when state is B, low otherwise

endmodule
