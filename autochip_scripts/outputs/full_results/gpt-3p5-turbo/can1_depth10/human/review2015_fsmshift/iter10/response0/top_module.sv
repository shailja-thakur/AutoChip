module top_module(
    input clk,
    input reset,
    output reg shift_ena);

    reg [3:0] count;
    reg enable;

    always @(posedge clk) begin
        if (reset) begin
            count <= 4'd0;
            enable <= 1'b1;
        end else if (enable && count != 4'd3) begin
            count <= count + 1'd1;
            enable <= 1'b1;
        end else begin
            count <= 4'd0;
            enable <= 1'b0;
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            shift_ena <= 1'b1;
        end else if (enable && count == 4'd3) begin
            shift_ena <= 1'b1;
        end else begin
            shift_ena <= 1'b0;
        end
    end

endmodule
