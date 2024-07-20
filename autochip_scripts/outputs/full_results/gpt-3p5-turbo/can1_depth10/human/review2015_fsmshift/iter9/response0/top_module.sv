module top_module(
    input clk,
    input reset,
    output reg shift_ena);

    reg [1:0] count;
    reg enable;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 2'b00;
            enable <= 1'b1;
        end else if (count != 2'b11) begin
            count <= count + 1'b1;
            enable <= 1'b1;
        end else begin
            count <= 2'b00;
            enable <= 1'b0;
        end
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_ena <= 1'b0;
        end else if (enable && count == 2'b11) begin
            shift_ena <= 1'b1;
        end else begin
            shift_ena <= 1'b0;
        end
    end

endmodule
