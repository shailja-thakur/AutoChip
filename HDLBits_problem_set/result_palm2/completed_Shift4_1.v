module top_module (
    input clk,
    input areset,  // async active-high reset to zero
    input load,
    input ena,
    input [3:0] data,
    output reg [3:0] q); 

    reg [3:0] d;
    reg [3:0] q_reg;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            q <= 4'b0;
        end else begin
            if (load) begin
                q <= data;
            end else if (ena) begin
                q <= q_reg >> 1;
            end
        end
    end

    assign d = q_reg;

    DFF d_ff (
        .clk(clk),
        .d(d),
        .q(q_reg)
    );

endmodule