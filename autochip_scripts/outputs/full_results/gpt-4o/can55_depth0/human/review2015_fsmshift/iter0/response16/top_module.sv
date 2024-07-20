module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

    reg [2:0] counter;  // Counter to keep track of clock cycles

    always @(posedge clk) begin
        if (reset) begin
            shift_ena <= 1;
            counter <= 3'b000;
        end else if (shift_ena) begin
            if (counter < 3'b011) begin
                counter <= counter + 1;
            end else begin
                shift_ena <= 0;
            end
        end else begin
            shift_ena <= 0;
        end
    end

endmodule
