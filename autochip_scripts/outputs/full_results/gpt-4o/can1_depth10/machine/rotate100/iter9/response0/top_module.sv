module top_module(
    input clk,
    input load,
    input [1:0] ena,
    input [99:0] data,
    output reg [99:0] q
);

    always @(posedge clk) begin
        if (load) begin
            q <= data;  // Load data into q when load is high
        end
        else begin
            case (ena)
                2'h1: q <= {q[98:0], q[99]};  // Rotate left by 1 bit
                2'h2: q <= {q[0], q[99:1]};  // Rotate right by 1 bit
                default: q <= q;  // Maintain current state
            endcase
        end
    end

endmodule
