module top_module(
    input clk,
    input reset,
    output shift_ena
    );

    reg [3:0] count;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 4'b0;
            shift_ena <= 1'b0;
        end else begin
            if (count == 4'b0) begin
                shift_ena <= 1'b0;
            end else if (/*proper bit pattern is detected*/) begin
                shift_ena <= 1'b1;
            end else begin
                shift_ena <= shift_ena;
            end

            if (count != 4'b0) begin
                count <= count - 1'b1;
            end
        end
    end

endmodule
