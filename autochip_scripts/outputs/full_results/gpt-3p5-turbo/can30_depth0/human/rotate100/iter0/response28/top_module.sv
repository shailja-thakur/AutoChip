module top_module(
    input clk,
    input load,
    input [1:0] ena,
    input [99:0] data,
    output reg [99:0] q);
    
    reg [99:0] shift_reg;
    reg [99:0] q_reg;
    reg [99:0] rot_left;
    reg [99:0] rot_right;

    always @(posedge clk) begin
        if (load) begin
            shift_reg <= data;
            q_reg <= data;
        end
        else begin
            if (ena == 2'b01) begin
                rot_left[99:1] <= shift_reg[98:0];
                rot_left[0] <= shift_reg[99];
                q_reg <= rot_left;
                shift_reg <= rot_left;
            end
            else if (ena == 2'b10) begin
                rot_right[98:0] <= shift_reg[99:1];
                rot_right[99] <= shift_reg[0];
                q_reg <= rot_right;
                shift_reg <= rot_right;
            end
            else begin
                q_reg <= shift_reg;
                shift_reg <= shift_reg;
            end
        end
    end

    assign q = q_reg;

endmodule
