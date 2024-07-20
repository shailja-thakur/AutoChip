module top_module(
    input clk,
    input load,
    input [1:0] ena,
    input [99:0] data,
    output reg [99:0] q);

    reg [99:0] temp_q;

    always @(posedge clk) begin
        if (load) begin
            temp_q <= data;
        end else begin
            case (ena)
                2'b01: temp_q <= {temp_q[98:0], 1'b0};
                2'b10: temp_q <= {1'b0, temp_q[99:1]};
                default: temp_q <= temp_q;  // No shift
            endcase
        end
    end

    always @(posedge clk) begin
        q <= temp_q;
    end

endmodule
