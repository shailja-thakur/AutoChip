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
        end else begin
            if (count == 4)
                count <= 4'b0000;
            else
                count <= count + 1'b1;

            enable <= (count < 4);
        end
    end

    always @(posedge clk) begin
        if (reset)
            shift_ena <= 1'b1;
        else begin
            if (count == 4'b0000)
                shift_ena <= 1'b1;
            else
                shift_ena <= 1'b0;
        end
    end

endmodule
