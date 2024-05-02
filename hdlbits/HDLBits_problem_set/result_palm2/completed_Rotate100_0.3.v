module top_module(
    input clk,
    input load,
    input [1:0] ena,
    input [99:0] data,
    output reg [99:0] q); 

    // Shift register
    reg [99:0] sr;

    // Control signals
    wire [1:0] dir;
    wire load_sr;

    // Decoder
    assign dir = ena[1:0];
    assign load_sr = load;

    // Load data into shift register
    always @(posedge clk or posedge load) begin
        if (load) begin
            sr <= data;
        end
    end

    // Rotate shift register
    always @(posedge clk) begin
        if (dir == 2'b01) begin
            sr[99:0] <= sr[98:0];
            sr[0] <= sr[99];
        end else if (dir == 2'b10) begin
            sr[99:0] <= sr[97:0];
            sr[0] <= sr[98];
        end
    end

    // Output the contents of the shift register
    assign q = sr;

endmodule