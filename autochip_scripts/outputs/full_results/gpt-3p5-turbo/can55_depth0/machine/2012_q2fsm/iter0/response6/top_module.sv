module top_module (
    input clk,
    input reset,
    input w,
    output z
);
    reg [2:0] state;
    wire e_or_f;

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 3'b000;
        else if (w == 1'b0) begin
            case (state)
                3'b000: state <= 3'b000;
                3'b001: state <= 3'b101;
                3'b010: state <= 3'b101;
                3'b011: state <= 3'b000;
                3'b100: state <= 3'b101;
                default: state <= 3'b101;
            endcase
        end else begin
            case (state)
                3'b000: state <= 3'b001;
                3'b001: state <= 3'b010;
                3'b010: state <= 3'b100;
                3'b011: state <= 3'b111;
                3'b100: state <= 3'b100;
                default: state <= 3'b010;
            endcase
        end
    end

    assign e_or_f = (state == 3'b100) || (state == 3'b111);
    assign z = e_or_f;

endmodule
