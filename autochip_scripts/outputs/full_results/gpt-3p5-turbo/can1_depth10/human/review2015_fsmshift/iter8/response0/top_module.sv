module top_module(
    input clk,
    input reset,
    output reg shift_ena);

    reg [3:0] count;
    reg enable;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 4'b0000;
            enable <= 1'b1;
        end else if (enable && count != 4'b1100) begin
            count <= count + 1'b1;
            enable <= 1'b1;
        end else begin
            count <= 4'b0000;
            enable <= 1'b0;
        end
    end

    always @(posedge clk) begin
        if (reset)
            shift_ena <= 1'b0;
        else begin
            if (count == 4'b1100)
                shift_ena <= 1'b1;
            else
                shift_ena <= 1'b0;
        end
    end

endmodule
