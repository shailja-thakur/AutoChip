module top_module(
    input clk,
    input reset,
    output shift_ena
);

    reg [2:0] state;

    always @(posedge clk) begin
        if (reset) begin
            state <= 0;
        end else begin
            case (state)
                3'b000: state <= 3'b001;
                3'b001: state <= 3'b010;
                3'b010: state <= 3'b011;
                3'b011: state <= 3'b100;
                default: state <= 3'b100;
            endcase
        end
    end

    assign shift_ena = (state != 3'b100);

endmodule
