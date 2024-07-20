module top_module (
    input clk,
    input areset,
    input x,
    output z
);

    reg [1:0] state;
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= 2'b00;
        else
            case(state)
                2'b00: state <= x ? 2'b01 : 2'b00;
                2'b01: state <= x ? 2'b00 : 2'b01;
                default: state <= state;
            endcase
    end

    assign z = (state == 2'b10) ? 1'b0 : 1'b1;

endmodule
