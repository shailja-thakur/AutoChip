module top_module (
    input clk,
    input load,
    input [1:0] ena,
    input [99:0] data,
    output reg [99:0] q);

    // The shift register
    reg [99:0] sr;

    // The control signals
    wire [1:0] dir = ena[1:0];
    wire load_en = load & (ena[1:0] == 2'b00);

    // The shift logic
    always @(posedge clk or posedge load) begin
        if (load_en) begin
            sr <= data;
        end else if (dir == 2'b01) begin
            sr[99:0] <= sr[98:0];
            sr[98] <= sr[97];
        end else if (dir == 2'b10) begin
            sr[99:0] <= sr[97:0];
            sr[96] <= sr[95];
        end
    end

    // The output
    assign q = sr;

endmodule