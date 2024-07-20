module top_module(
    input wire clk,
    input wire reset,
    output wire shift_ena);

    reg [2:0] state;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= 3'b000;
        end else if (state == 3'b100) begin
            state <= 3'b000;
        end else if (state < 3'b011) begin
            state <= state + 1;
        end else begin
            state <= 3'b100;
        end
    end

    assign shift_ena = (state != 3'b000);

endmodule
