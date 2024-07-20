module top_module(
    input clk,
    input reset,
    output shift_ena
);

reg [3:0] counter;
wire shift_ena_int;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        counter <= 4'b1111;
    end else if (counter > 0) begin
        counter <= counter - 1;
    end
end

assign shift_ena_int = (counter > 0);

always @(posedge clk) begin
    if (reset) begin
        shift_ena <= 1'b0;
    end else begin
        shift_ena <= shift_ena_int;
    end
end

endmodule
