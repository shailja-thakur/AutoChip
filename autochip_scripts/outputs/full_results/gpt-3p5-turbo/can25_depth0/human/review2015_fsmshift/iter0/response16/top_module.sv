module top_module(
    input clk,
    input reset,
    output shift_ena
    );

    reg [3:0] cnt;
    reg shift_ena;

    always @(posedge clk) begin
        if (reset) begin
            cnt <= 4'd0;
            shift_ena <= 1'b1;
        end else if (cnt < 4'd3) begin
            cnt <= cnt + 1'd1;
            shift_ena <= 1'b1;
        end else begin
            cnt <= 4'd0;
            shift_ena <= 1'b0;
        end
    end

endmodule
