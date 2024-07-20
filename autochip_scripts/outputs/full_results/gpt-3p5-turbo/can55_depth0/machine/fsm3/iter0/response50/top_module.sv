module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    reg [1:0] state;
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b00;
        end else begin
            case (state)
                2'b00: state <= in ? 2'b01 : 2'b00;
                2'b01: state <= in ? 2'b01 : 2'b10;
                2'b10: state <= in ? 2'b11 : 2'b00;
                2'b11: state <= in ? 2'b01 : 2'b10;
            endcase
        end
    end

    assign out = (state == 2'b11);

endmodule
