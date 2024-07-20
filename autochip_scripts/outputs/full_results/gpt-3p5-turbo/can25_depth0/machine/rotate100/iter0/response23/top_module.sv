module top_module(
    input clk,
    input load,
    input [1:0] ena,
    input [99:0] data,
    output reg [99:0] q);

    reg [99:0] output_reg;

    always @(posedge clk) begin
        if (load)
            output_reg <= data; // load data into output register
        else begin
            case (ena)
                2'b01: output_reg <= output_reg << 1; // left shift
                2'b10: output_reg <= output_reg >> 1; // right shift
                default: output_reg <= output_reg; // no shift
            endcase
        end
    end

    assign q = output_reg;

endmodule
