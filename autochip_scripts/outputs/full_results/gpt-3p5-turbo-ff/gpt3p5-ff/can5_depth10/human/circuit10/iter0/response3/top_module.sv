module top_module (
    input clk,
    input a,
    input b,
    output q,
    output state
);
    
    reg q_reg;
    wire state_wire;

    always @(posedge clk) begin
        if (a & ~b) begin
            q_reg <= 1'b1;
        end else if (~a & b) begin
            q_reg <= 1'b0;
        end
    end

    assign q = q_reg;
    assign state = state_wire;

endmodule
