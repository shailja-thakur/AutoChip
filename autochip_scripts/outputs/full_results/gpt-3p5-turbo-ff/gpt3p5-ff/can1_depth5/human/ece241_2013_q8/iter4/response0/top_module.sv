module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state;
reg [2:0] sequence;

always @(posedge clk or negedge aresetn) begin
    if (~aresetn)
        state <= 2'b00;
    else
        case (state)
            2'b00: begin
                if (x)
                    state <= 2'b01;
            end
            2'b01: begin
                if (x)
                    state <= 2'b10;
                else
                    state <= 2'b00;
            end
            2'b10: begin
                sequence <= {sequence[1:0], x};
                state <= (sequence == 3'b101) ? 2'b10 : 2'b00;
            end
        endcase
end

always @(posedge clk) begin
    z <= (state == 2'b10) ? 1'b1 : 1'b0;
end

endmodule
