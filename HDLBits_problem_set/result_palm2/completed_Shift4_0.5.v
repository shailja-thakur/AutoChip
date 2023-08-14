module top_module(
    input clk,
    input areset,  // async active-high reset to zero
    input load,
    input ena,
    input [3:0] data,
    output reg [3:0] q); 

    reg [3:0] d;
    reg [3:0] q_reg;

    always @(posedge clk) begin
        if (areset) begin
            q_reg <= 4'b0;
        end else begin
            if (load) begin
                q_reg <= data;
            end else if (ena) begin
                q_reg <= q_reg >> 1;
                q_reg[0] <= data[3];
            end
        end
    end

    assign q = q_reg;

endmodule