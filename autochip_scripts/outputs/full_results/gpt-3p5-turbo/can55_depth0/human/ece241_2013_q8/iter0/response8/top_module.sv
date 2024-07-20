module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state;
reg prev_x;

always @(posedge clk or negedge aresetn)
begin
    if (!aresetn)
        state <= 2'b00;
    else
        case (state)
            2'b00: if (x && !prev_x) state <= 2'b01; else state <= 2'b00;
            2'b01: if (x && prev_x) state <= 2'b10; else state <= 2'b00;
            2'b10: if (x && !prev_x) state <= 2'b01; else state <= 2'b00;
            default: state <= 2'b00;
        endcase
end

always @(state)
begin
    case (state)
        2'b10: z <= 1'b1;
        default: z <= 1'b0;
    endcase
end

always @(posedge clk)
begin
    prev_x <= x;
end

endmodule
