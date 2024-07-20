module top_module(
    input clk,
    input areset,
    input load,
    input ena,
    input [3:0] data,
    output reg [3:0] q
);

reg [3:0] q_reg;

always @(posedge clk or posedge areset) begin
    if(areset) begin
        q_reg <= 4'd0;
    end
    else if(load) begin
        q_reg <= data;
    end
    else if(ena) begin
        q_reg <= {q_reg[2:0], q_reg[3]};
    end
end

assign q = q_reg;

endmodule
