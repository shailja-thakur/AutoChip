module top_module(
    input clk,
    input reset,
    output reg [3:1] ena,
    output reg [15:0] q
);
// define internal wires and reg
wire clk_edge;
wire [15:0] next_q;
reg [15:0] q_reg;

// Create positive edge of clk signal
always @(posedge clk) begin
    clk_edge <= 1;
    #1 clk_edge <= 0;
end

// Assign next value of q based on enable signals
always @(posedge clk_edge or posedge reset) begin
    if (reset) begin
        q_reg <= 0;
    end else if (ena == 3'b001) begin
        q_reg <= q_reg + 1;
    end else if (ena == 3'b010) begin
        q_reg <= q_reg + 10;
    end else if (ena == 3'b100) begin
        q_reg <= q_reg + 100;
    end
end

// Assign current value of q
always @(posedge clk_edge) begin
    q <= q_reg;
end

// Assign enabled signals based on current value of q
always @(posedge clk_edge or posedge reset) begin
    if (reset) begin
        ena <= 3'b000;
    end else if (q[15:12] < 10) begin
        ena <= 3'b001;
    end else if (q[15:12] >= 10 && q[15:12] < 90) begin
        ena <= 3'b011;
    end else if (q[15:12] >= 90) begin
        ena <= 3'b111;
    end
end

endmodule
