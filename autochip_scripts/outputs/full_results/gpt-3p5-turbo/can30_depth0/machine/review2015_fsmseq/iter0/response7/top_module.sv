module top_module(
    input clk,
    input reset,
    input data,
    output start_shifting
);

reg [2:0] state;
reg start_shifting;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 3'b000;
        start_shifting <= 0;
    end else begin
        case (state)
            3'b000: begin
                if (data)
                    state <= 3'b001;
                else
                    state <= 3'b000;
                start_shifting <= 0;
            end
            3'b001: begin
                if (data)
                    state <= 3'b011;
                else
                    state <= 3'b000;
                start_shifting <= 0;
            end
            3'b011: begin
                if (data)
                    state <= 3'b011;
                else
                    state <= 3'b110;
                start_shifting <= 0;
            end
            3'b110: begin
                if (data)
                    state <= 3'b111;
                else
                    state <= 3'b000;
                start_shifting <= 0;
            end
            3'b111: begin
                state <= 3'b111;
                start_shifting <= 1;
            end
            default: begin
                state <= 3'b000;
                start_shifting <= 0;
            end
        endcase
    end
end

endmodule
