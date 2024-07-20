module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state;

always @(posedge clk or negedge aresetn)
begin
    if (!aresetn)
        state <= 2'b00;
    else
    begin
        case (state)
            2'b00:
                if (x)
                    state <= 2'b01;
            2'b01:
                if (!x)
                    state <= 2'b10;
            2'b10:
                if (x)
                begin
                    state <= 2'b11;
                    z <= 1'b1;
                end
                else
                    state <= 2'b01;
            2'b11:
                if (!x)
                    state <= 2'b10;
        endcase
    end
end

endmodule
