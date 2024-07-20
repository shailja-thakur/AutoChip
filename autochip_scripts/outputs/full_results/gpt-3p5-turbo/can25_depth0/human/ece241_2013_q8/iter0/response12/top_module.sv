module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state, next_state;

always @(posedge clk or negedge aresetn) begin
    if (!aresetn)
        state <= 2'b00;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        2'b00:
            if (x)
                next_state = 2'b01;
            else
                next_state = 2'b00;
        2'b01:
            if (x)
                next_state = 2'b01;
            else
                next_state = 2'b10;
        2'b10:
            if (x)
                next_state = 2'b11;
            else
                next_state = 2'b00;
        2'b11:
            next_state = 2'b00;
    endcase
end

always @(state) begin
    if (state == 2'b10)
        z = 1'b1;
    else
        z = 1'b0;
end

endmodule
