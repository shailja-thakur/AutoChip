module top_module(
    input clk,
    input load,
    input [1:0] ena,
    input [99:0] data,
    output reg [99:0] q
);

reg [99:0] shift_reg;
reg [99:0] temp_reg;

always @(posedge clk) begin
    if(load) begin
        shift_reg <= data;
    end else begin
        case(ena)
            2'b01: begin
                temp_reg[0] <= shift_reg[99];
                temp_reg[1:99] <= shift_reg[0:98];
                shift_reg <= temp_reg;
            end
            2'b10: begin
                temp_reg[0:98] <= shift_reg[1:99];
                temp_reg[99] <= shift_reg[0];
                shift_reg <= temp_reg;
            end
            default: begin
                // No rotation
                shift_reg <= shift_reg;
            end
        endcase
    end
end

assign q = shift_reg;

endmodule
