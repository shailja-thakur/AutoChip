module top_module (
    input clk,
    input in,
    input reset,
    output out
);

reg [1:0] state;
reg outReg;
always @(posedge clk or posreset) begin
    if (reset) begin
        state <= 2'b00;
        outReg <= 1'b0;
    end else begin
        case (state)
            2'b00: begin
                if (in) begin
                    state <= 2'b01;
                end else begin
                    state <= 2'b00;
                end
                outReg <= 1'b0;
            end
            2'b01: begin
                if (in) begin
                    state <= 2'b01;
                end else begin
                    state <= 2'b10;
                end
                outReg <= 1'b0;
            end
            2'b10: begin
                if (in) begin
                    state <= 2'b11;
                end else begin
                    state <= 2'b00;
                end
                outReg <= 1'b0;
            end
            2'b11: begin
                if (in) begin
                    state <= 2'b01;
                end else begin
                    state <= 2'b10;
                end
                outReg <= 1'b1;
            end
        endcase
    end
end

assign out = outReg;

endmodule
