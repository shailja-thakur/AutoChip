module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

reg [1:0] state;
reg third_bit;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 2'b00;
    else begin
        case (state)
            2'b00: begin
                if (in[2] == 1'b1)
                    state <= 2'b01;
                else
                    state <= 2'b00;
            end
            2'b01: begin
                state <= 2'b10;
            end
            2'b10: begin
                state <= 2'b11;
            end
            2'b11: begin
                if (in[2] == 1'b0)
                    state <= 2'b00;
                else
                    state <= 2'b01;
            end
            default: state <= 2'b00;
        endcase
    end
end

assign third_bit = in[2];

always @(posedge clk or posedge reset) begin
    if (reset)
        done <= 1'b0;
    else begin
        if (state == 2'b11)
            done <= 1'b1;
        else
            done <= 1'b0;
    end
end

endmodule
