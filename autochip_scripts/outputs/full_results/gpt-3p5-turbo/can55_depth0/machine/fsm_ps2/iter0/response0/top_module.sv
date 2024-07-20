module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

reg [1:0] state;
reg done;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 2'b0;
    else begin
        case (state)
            2'b00:
                if (in[2] == 1)
                    state <= 2'b01;
            2'b01:
                state <= 2'b10;
            2'b10:
                state <= 2'b11;
            2'b11:
                if (in[2] == 0)
                    state <= 2'b00;
                else
                    state <= 2'b01;
        endcase
    end

end

assign done = (state == 2'b11);

endmodule
